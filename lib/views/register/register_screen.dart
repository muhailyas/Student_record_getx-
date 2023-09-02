import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/student.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../utils/image_picker/image_picker.dart';
import '../../validators/validation_functions.dart';
import '../home/home_screen.dart';
import '../widgets/text_field_widget/text_field_widget.dart';

XFile? image;

class ScreenRegister extends StatelessWidget {
  ScreenRegister({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController batchController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          studentViewController.image.value = '';
          return true;
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  kWidthDoubleInfinity,
                  kSizedBox30,
                  Stack(
                    children: [
                      kWidthDoubleInfinity,
                      Positioned(
                        child: IconButton(
                            onPressed: () {
                              studentViewController.image.value = '';
                              Get.back();
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios_new,
                              color: kFontColorWhite,
                            )),
                      ),
                      const Positioned(
                        top: 10,
                        left: 140,
                        child: Text(
                          "Registeration",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  kSizedBox10,
                  Obx(() {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.height * 0.2,
                      decoration: BoxDecoration(
                        color: kThemeColorGreen,
                        image: studentViewController.image.value.isNotEmpty
                            ? DecorationImage(
                                image: FileImage(
                                    File(studentViewController.image.value)),
                                fit: BoxFit.cover)
                            : null,
                        shape: BoxShape.circle,
                      ),
                      child: Align(
                          alignment: const Alignment(0.8, -.7),
                          child: IconButton(
                            icon: const Icon(
                              Icons.add_a_photo_outlined,
                              size: 35,
                              color: kThemeWhite,
                            ),
                            onPressed: () async {
                              image = await imagePicker();
                              if (image != null) {
                                studentViewController.setImage(image!.path);
                              }
                            },
                          )),
                    );
                  }),
                  kSizedBox20,
                  TextFormFieldWidget(
                      hintText: 'Name',
                      controller: nameController,
                      function: isValidName),
                  TextFormFieldWidget(
                    hintText: 'Age',
                    controller: ageController,
                    function: isValidAge,
                  ),
                  TextFormFieldWidget(
                    hintText: 'Batch',
                    controller: batchController,
                    function: isValidBatch,
                  ),
                  TextFormFieldWidget(
                    hintText: 'Mobile',
                    controller: mobileController,
                    function: isValidMobileNumber,
                  ),
                  TextFormFieldWidget(
                    hintText: 'Email',
                    controller: emailController,
                    function: isValidEmail,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: TextButton.icon(
                              style: const ButtonStyle(
                                  foregroundColor:
                                      MaterialStatePropertyAll(kFontColorWhite),
                                  backgroundColor: MaterialStatePropertyAll(
                                      kThemeColorGreen),
                                  fixedSize: MaterialStatePropertyAll(
                                    Size(210, 50),
                                  )),
                              onPressed: () {
                                validate(context);
                              },
                              icon: const Icon(Icons.save),
                              label: const Text("Save")),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: TextButton.icon(
                              style: const ButtonStyle(
                                  foregroundColor:
                                      MaterialStatePropertyAll(kFontColorWhite),
                                  backgroundColor: MaterialStatePropertyAll(
                                      kThemeColorGreen),
                                  fixedSize: MaterialStatePropertyAll(
                                    Size(210, 50),
                                  )),
                              onPressed: () async {
                                image = await imagePicker();
                                if (image != null) {
                                  studentViewController.setImage(image!.path);
                                }
                              },
                              icon: const Icon(
                                Icons.cloud_upload,
                              ),
                              label: const Text("Upload Image")),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void validate(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return;
    } else if (image == null) {
      Get.snackbar(
        "Image",
        'Image is required',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
      return;
    }
    final student = StudentModel(
        name: nameController.text,
        age: ageController.text,
        batch: batchController.text,
        mobile: mobileController.text,
        email: emailController.text,
        image: image!.path);
    await studentViewController.addStudent(student);
    Get.snackbar(
      "Successfull",
      'Student added successfully',
      snackPosition: SnackPosition.BOTTOM,
      colorText: kFontColorWhite,
      backgroundColor: kThemeColorGreen,
    );
    clearForm();
  }

  void clearForm() {
    nameController.clear();
    ageController.clear();
    batchController.clear();
    mobileController.clear();
    emailController.clear();
    image = null;
    studentViewController.image.value = '';
  }
}
