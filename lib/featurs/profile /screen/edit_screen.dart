import 'package:flutter/material.dart';
import 'dart:io';
import '../../../common/app_shell.dart';
import '../../../common/custom_button.dart';
import '../widget/custom_edit.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {


  @override
  Widget build(BuildContext context) {
    return SubPageScaffold(
      parentTabIndex: 4,
      backgroundColor:  Colors.black87,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.black87,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xffE0712D),
            size: 18,
          ),
        ),
        title: const Text(
          "Edit Profile",
          style: TextStyle(
            color: Color(0xffE0712D),
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Center(
                child: Container(
                  width: 170,
                  height: 170,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                          child:  Icon(
                            Icons.person,
                            size: 150,
                            color: Colors.grey,
                          ),
                  ),
                  ),
                ),
              const SizedBox(height: 7),
              GestureDetector(
                onTap: (){},
                child: const Text(
                  'Change photo',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffE0712D),
                    decoration: TextDecoration.underline,
                    decorationColor: Color(0xffE0712D),
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
                hintText: "Type your address here",
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 30),
              CustomEdit(
                title: "Age",
                hintText: "Type your age here",
              ),
              const SizedBox(height: 30),
              CustomButton(
                text:  "Save",
                onTap: () {} ,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}