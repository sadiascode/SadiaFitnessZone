import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../common/app_shell.dart';
import '../../../common/custom_button.dart';
import '../../../common/custom_color.dart';
import '../widget/custom_edit.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final supabase = Supabase.instance.client;
  String? _selectedImagePath;
  String? _avatarUrl;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final ageController = TextEditingController();
  final healthController = TextEditingController();
  final wakeupController = TextEditingController();

  bool isLoading = true;
  bool isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    try {
      final userId = supabase.auth.currentUser?.id;
      if (userId == null) return;

      final data = await supabase
          .from('profiles')
          .select()
          .eq('id', userId)
          .single();

      if (mounted) {
        setState(() {
          nameController.text = data['full_name'] ?? "";
          emailController.text = data['email'] ?? "";
          addressController.text = data['address'] ?? "";
          ageController.text = data['age']?.toString() ?? "";
          healthController.text = data['health_condition'] ?? "";
          wakeupController.text = data['wakeup_time'] ?? "";
          _avatarUrl = data['avatar_url'];
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading profile: $e')),
        );
      }
    }
  }

  Future<void> _updateProfile() async {
    setState(() {
      isSaving = true;
    });

    try {
      final userId = supabase.auth.currentUser?.id;
      if (userId == null) return;

      String? newAvatarUrl;
      // Upload image if a new one was selected
      if (_selectedImagePath != null) {
        final file = File(_selectedImagePath!);
        final fileExtension = file.path.split('.').last;
        final fileName = '${userId}_${DateTime.now().millisecondsSinceEpoch}.$fileExtension';
        
        await supabase.storage.from('avatars').upload(
          fileName,
          file,
          fileOptions: const FileOptions(cacheControl: '3600', upsert: true),
        );
        newAvatarUrl = supabase.storage.from('avatars').getPublicUrl(fileName);
      }

      int? ageValue;
      if (ageController.text.isNotEmpty) {
        ageValue = int.tryParse(ageController.text);
      }

      final updateData = {
        'full_name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'address': addressController.text.trim(),
        'age': ageValue,
        'health_condition': healthController.text.trim(),
        'wakeup_time': wakeupController.text.trim(),
      };

      if (newAvatarUrl != null) {
        updateData['avatar_url'] = newAvatarUrl;
      }

      await supabase.from('profiles').update(updateData).eq('id', userId);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully!')),
        );
        Navigator.pop(context, true); // Pass true to signal reload
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating profile: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isSaving = false;
        });
      }
    }
  }

  // Camera & Gallery Picker
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () async {
                  Navigator.of(context).pop();
                  final XFile? image =
                      await picker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    setState(() {
                      _selectedImagePath = image.path;
                    });
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () async {
                  Navigator.of(context).pop();
                  final XFile? image =
                      await picker.pickImage(source: ImageSource.camera);
                  if (image != null) {
                    setState(() {
                      _selectedImagePath = image.path;
                    });
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    addressController.dispose();
    ageController.dispose();
    healthController.dispose();
    wakeupController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SubPageScaffold(
      parentTabIndex: 4,
      backgroundColor: const Color(0xFF121215),
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: const Color(0xFF121215),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 18,
          ),
        ),
        title: const Text(
          "Edit Profile",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Color(0xff86CC55)))
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Center(
                      child: Container(
                        width: 130,
                        height: 130,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: AppColors.primaryGradient,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                          child: _selectedImagePath != null
                              ? Image.file(
                                  File(_selectedImagePath!),
                                  fit: BoxFit.cover,
                                )
                              : (_avatarUrl != null && _avatarUrl!.isNotEmpty)
                                  ? Image.network(
                                      _avatarUrl!,
                                      fit: BoxFit.cover,
                                      loadingBuilder: (context, child, loadingProgress) {
                                        if (loadingProgress == null) return child;
                                        return const Center(
                                            child: CircularProgressIndicator(color: Colors.white));
                                      },
                                      errorBuilder: (context, error, stackTrace) =>
                                          const Icon(Icons.person, size: 80, color: Colors.white),
                                    )
                                  : const Icon(
                                      Icons.person,
                                      size: 80,
                                      color: Colors.white,
                                    ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 7),
                    GestureDetector(
                      onTap: _pickImage,
                      child: const Text(
                        'Change photo',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff86CC55),
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0xff86CC55),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomEdit(
                      title: "Full Name",
                      hintText: "Enter your name",
                      controller: nameController,
                    ),
                    const SizedBox(height: 15),
                    CustomEdit(
                      title: "Email",
                      hintText: "Enter your email",
                      controller: emailController,
                    ),
                    const SizedBox(height: 15),
                    CustomEdit(
                      title: "Address",
                      hintText: "Enter your address here",
                      controller: addressController,
                    ),
                    const SizedBox(height: 15),
                    CustomEdit(
                      title: "Age",
                      hintText: "Enter your Age",
                      controller: ageController,
                    ),
                    const SizedBox(height: 15),
                    CustomEdit(
                      title: "Health condition",
                      hintText: "Enter your Health condition",
                      controller: healthController,
                    ),
                    const SizedBox(height: 15),
                    CustomEdit(
                      title: "Wakeup time",
                      hintText: "Enter your Wakeup time",
                      controller: wakeupController,
                    ),
                    const SizedBox(height: 30),
                    isSaving
                        ? const Center(child: CircularProgressIndicator(color: Color(0xff86CC55)))
                        : CustomButton(
                            text: "Save",
                            onTap: _updateProfile,
                          ),
                    const SizedBox(height: 120),
                  ],
                ),
              ),
            ),
    );
  }
}