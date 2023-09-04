import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_database_getx/controllers/student_controller/student_controller.dart';
import '../../models/student.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../validators/validation_functions.dart';
import '../home/home_screen.dart';
import '../register/register_screen.dart';
import '../widgets/text_field_widget/text_field_widget.dart';

class ScreenEditStduent extends GetView<StudentViewController> {
  ScreenEditStduent({super.key, required this.student});
  final StudentModel student;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController batchController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ImagePicker _imagePicker = ImagePicker();

  initializingValues() {
    nameController.text = student.name;
    ageController.text = student.age;
    batchController.text = student.batch;
    mobileController.text = student.mobile;
    emailController.text = student.email;
    studentViewController.image.value = student.image;
  }

  @override
  Widget build(BuildContext context) {
    initializingValues();
    return WillPopScope(
      onWillPop: () async {
        controller.image.value = '';
        return true;
      },
      child: SafeArea(
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
                      const Positioned(
                        top: 12,
                        left: 150,
                        child: Text(
                          "Edit Student",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
                      Positioned(
                          child: IconButton(
                              onPressed: () {
                                controller.image.value = '';
                                Get.back();
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios_new,
                                color: Colors.white,
                              )))
                    ],
                  ),
                  kSizedBox10,
                  Obx(() {
                    return Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        image: controller.image.value.isNotEmpty
                            ? DecorationImage(
                                image: FileImage(File(controller.image.value)),
                                fit: BoxFit.cover)
                            : null,
                        shape: BoxShape.circle,
                      ),
                      child: const Align(
                          alignment: Alignment(0.8, -.7),
                          child: Icon(
                            Icons.add_a_photo_outlined,
                            size: 35,
                            color: kThemeWhite,
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
                              label: const Text("Update")),
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
                                  controller.setImage(image!.path);
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
    } else if (controller.image.value.isEmpty) {
      Get.snackbar(
        "Image",
        'Image is required',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
      return;
    }

    final updatedStudent = StudentModel(
        name: nameController.text,
        age: ageController.text,
        batch: batchController.text,
        mobile: mobileController.text,
        email: emailController.text,
        image: controller.image.value);
    await controller.updateStudent(updatedStudent, student.id!);
    Get.back();
    image = null;
    controller.image.value = '';
    Get.snackbar(
      "Update",
      'Updated Successfully',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: kThemeColorGreen,
      colorText: kFontColorWhite,
    );
  }

  Future<XFile> imagePicker() async {
    try {
      final XFile? image =
          await _imagePicker.pickImage(source: ImageSource.gallery);
      if (image == null) {
        throw Exception("No image was selected.");
      }
      return image;
    } catch (e) {
      throw Exception(e);
    }
  }
}
