-- ==============================================================================
-- SUPABASE SCHEMA FOR FLUTTER NUTRITION/SOCIAL APP 
-- ==============================================================================

-- 1. USERS TABLE (Extending Supabase Auth)
CREATE TABLE public.profiles (
    id UUID REFERENCES auth.users(id) ON DELETE CASCADE PRIMARY KEY,
    full_name TEXT,
    email TEXT UNIQUE,
    avatar_url TEXT,
    address TEXT,
    age INTEGER,
    health_condition TEXT,
    wakeup_time TEXT, -- Or TIME depending on your Dart model
    user_level INTEGER DEFAULT 1,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Automate profile creation on user signup
CREATE OR REPLACE FUNCTION public.handle_new_user() 
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, email, full_name, avatar_url)
  VALUES (
    NEW.id, 
    NEW.email, 
    NEW.raw_user_meta_data->>'full_name', 
    NEW.raw_user_meta_data->>'avatar_url'
  );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE PROCEDURE public.handle_new_user();

-- 2. SOCIAL: FOLLOWERS & FRIENDS
CREATE TABLE public.user_relationships (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    follower_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
    following_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(follower_id, following_id)
);

-- 3. CHAT: ROOMS AND MESSAGES
CREATE TABLE public.chat_rooms (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    is_group BOOLEAN DEFAULT FALSE,
    name TEXT, -- Used if it's a group chat
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE public.chat_participants (
    room_id UUID REFERENCES public.chat_rooms(id) ON DELETE CASCADE,
    user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
    joined_at TIMESTAMPTZ DEFAULT NOW(),
    PRIMARY KEY (room_id, user_id)
);

CREATE TABLE public.messages (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    room_id UUID REFERENCES public.chat_rooms(id) ON DELETE CASCADE,
    sender_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
    message_type TEXT CHECK (message_type IN ('text', 'image', 'audio', 'video')),
    content TEXT,
    media_url TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 4. LIVE STREAMING: ROOMS & SEATS
CREATE TABLE public.live_rooms (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    host_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
    title TEXT NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    share_link TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    ended_at TIMESTAMPTZ
);

CREATE TABLE public.live_room_members (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    room_id UUID REFERENCES public.live_rooms(id) ON DELETE CASCADE,
    user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
    role TEXT CHECK (role IN ('host', 'co_host', 'viewer')),
    seat_index INTEGER, -- For UI seat layout (e.g., host at top, members at bottom)
    joined_at TIMESTAMPTZ DEFAULT NOW()
);

-- 5. MALL & SHOPPING (User Level Items)
CREATE TABLE public.mall_items (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    name TEXT NOT NULL,
    description TEXT,
    price_coins INTEGER DEFAULT 0,
    item_type TEXT CHECK (item_type IN ('frame', 'badge', 'effect')),
    required_level INTEGER DEFAULT 1,
    image_url TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE public.user_purchases (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
    item_id UUID REFERENCES public.mall_items(id) ON DELETE CASCADE,
    purchased_at TIMESTAMPTZ DEFAULT NOW()
);

-- ==============================================================================
-- ROW LEVEL SECURITY (RLS) POLICIES
-- ==============================================================================

-- Enable RLS on all tables
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_relationships ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.chat_rooms ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.chat_participants ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.messages ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.live_rooms ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.live_room_members ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.mall_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_purchases ENABLE ROW LEVEL SECURITY;

-- Profile Policies (Everyone can view, only owner can update)
CREATE POLICY "Public profiles are viewable by everyone." ON public.profiles FOR SELECT USING (true);
CREATE POLICY "Users can insert their own profile." ON public.profiles FOR INSERT WITH CHECK (auth.uid() = id);
CREATE POLICY "Users can update own profile." ON public.profiles FOR UPDATE USING (auth.uid() = id);

-- Relationship Policies (Followers)
CREATE POLICY "Relationships are viewable by everyone." ON public.user_relationships FOR SELECT USING (true);
CREATE POLICY "Users can follow others." ON public.user_relationships FOR INSERT WITH CHECK (auth.uid() = follower_id);
CREATE POLICY "Users can unfollow." ON public.user_relationships FOR DELETE USING (auth.uid() = follower_id);

-- Chat Participants and Messages Policies
CREATE POLICY "Users can view chats they are part of." ON public.chat_participants FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can view messages in their rooms." ON public.messages FOR SELECT USING (
    EXISTS (SELECT 1 FROM public.chat_participants WHERE room_id = messages.room_id AND user_id = auth.uid())
);
CREATE POLICY "Users can send messages to their rooms." ON public.messages FOR INSERT WITH CHECK (
    auth.uid() = sender_id AND
    EXISTS (SELECT 1 FROM public.chat_participants WHERE room_id = messages.room_id AND user_id = auth.uid())
);

-- Live Room Policies
CREATE POLICY "Anyone can view live rooms." ON public.live_rooms FOR SELECT USING (true);
CREATE POLICY "Users can create live rooms." ON public.live_rooms FOR INSERT WITH CHECK (auth.uid() = host_id);
CREATE POLICY "Hosts can update their live rooms." ON public.live_rooms FOR UPDATE USING (auth.uid() = host_id);

-- Mall & Purchasing Policies
CREATE POLICY "Anyone can view mall items." ON public.mall_items FOR SELECT USING (true);
CREATE POLICY "Users can view their own purchases." ON public.user_purchases FOR SELECT USING (auth.uid() = user_id);

-- ==============================================================================
-- DELETE ACCOUNT RPC
-- ==============================================================================
-- A Security Definer function to allow users to delete their own account from auth.users
CREATE OR REPLACE FUNCTION public.delete_user()
RETURNS void AS $$
BEGIN
  DELETE FROM auth.users WHERE id = auth.uid();
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
