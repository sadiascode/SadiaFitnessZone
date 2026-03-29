import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/featurs/chat/screen%20/chat_screen.dart';
import 'package:todo/featurs/features/screen/features_screen.dart';

import '../../featurs/home /screen/home_screen.dart';
import '../../featurs/nutrition/screen/nutrition_screen.dart';
import '../../featurs/profile /screen/profile_screen.dart';
import 'bottom_tab_item.dart';

final List<BottomTabItem> bottomTabs = [
  BottomTabItem(
    label: "Home",
    icon: Icon(Icons.home),
    page: HomeScreen(),
    isCenter: true,
  ),
  BottomTabItem(
    label: "Feature",
    icon: Icon(Icons.fitness_center),
    page: FeaturesScreen(),
  ),
  BottomTabItem(
    label: "Nutrition",
    icon: Icon(Icons.local_dining),
    page: NutritionScreen(),
  ),
  BottomTabItem(
    label: "Chat",
    icon: Icon(Icons.chat),
    page: ChatScreen(),
  ),
  BottomTabItem(
    label: "Profile",
    icon: Icon(Icons.person),
    page: ProfileScreen(),
  ),
];