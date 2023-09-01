import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/student.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';

class StudentDetails extends StatelessWidget {
  const StudentDetails({super.key, required this.student});
  final StudentModel student;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SizedBox(
          height: double.infinity,
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.35,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://images.adsttc.com/media/images/632c/685a/8fa1/f901/6ee9/8047/medium_jpg/iowa-state-university-student-innovation-center-kierantimberlake_1.jpg?1663854747'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Positioned(
                right: 10,
                top: 10,
                child: Text(
                  "CODEVAULT EDU",
                  style: TextStyle(
                      fontSize: 35,
                      letterSpacing: -1,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Positioned(
                left: 15,
                top: 370,
                child: Material(
                  elevation: 205,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: kThemeColorGreen,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.215,
                    width: MediaQuery.of(context).size.width * 0.93,
                    decoration: BoxDecoration(
                      color: kThemeColorGreen,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          kSizedBox10,
                          SizedBox(
                            width: 240,
                            child: Text(
                              student.name,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: kFontColorWhite, fontSize: 24),
                            ),
                          ),
                          kSizedBox10,
                          Text(
                            "Age : ${student.age}",
                            style: const TextStyle(
                                color: kFontColorWhite, fontSize: 24),
                          ),
                          kSizedBox10,
                          Text(
                            "Batch : ${student.batch}",
                            style: const TextStyle(
                                color: kFontColorWhite, fontSize: 24),
                          ),
                          kSizedBox10,
                          Text(
                            "Mobile : ${student.mobile}",
                            style: const TextStyle(
                                color: kFontColorWhite, fontSize: 24),
                          ),
                          kSizedBox10,
                          Text(
                            "Email : ${student.email}",
                            style: const TextStyle(
                                color: kFontColorWhite, fontSize: 24),
                          ),
                          kSizedBox10,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 4,
                top: 352,
                child: Transform.rotate(
                  angle: 0 * pi / 180,
                  child: Container(
                    height: 95,
                    width: 190,
                    decoration: const BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(95),
                            bottomRight: Radius.circular(88))),
                  ),
                ),
              ),
              Positioned(
                right: 15,
                top: 265,
                child: Container(
                  height: 160,
                  width: 160,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: FileImage(File(student.image)),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              Positioned(
                left: 5,
                top: 5,
                child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 35,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
