import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:todo/featurs/profile%20/screen/myprofile_screen.dart';
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
  String? _selectedImagePath;

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
      body: SingleChildScrollView(
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
              ),
              const SizedBox(height: 15),
              CustomEdit(
                title: "Email",
                hintText: "Enter your email",
              ),
              const SizedBox(height: 15),
              CustomEdit(
                title: "Address",
                hintText: "Enter your address here",
              ),
              const SizedBox(height: 15),
              CustomEdit(
                title: "Age",
                hintText: "Enter your Age",
              ),
              const SizedBox(height: 15),
              CustomEdit(
                title: "Health condition",
                hintText: "Enter your Health condition",
              ),
              const SizedBox(height: 15),
              CustomEdit(
                title: "Wakeup time",
                hintText: "Enter your Wakeup time",
              ),
              const SizedBox(height: 30),
              CustomButton(
                text: "Save",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MyprofileScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
    );
  }
}