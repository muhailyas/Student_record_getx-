import 'dart:io';
import 'package:flutter/material.dart';
import '../../../../models/student.dart';
import '../../../../utils/colors.dart';
import '../popup_widget/popup_widget.dart';

class Student extends StatelessWidget {
  const Student({super.key, required this.student});
  final StudentModel student;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Container(
        decoration: BoxDecoration(
          color: kThemeColorGreen,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 20,
              left: 40,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.135,
                width: MediaQuery.of(context).size.height * 0.135,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: FileImage(File(student.image)),
                        fit: BoxFit.cover)),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 43,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 130,
                    child: Center(
                      child: Text(
                        student.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: kFontColorWhite,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Text(
                    "Batch: ${student.batch}",
                    style: const TextStyle(
                      fontSize: 15,
                      color: kFontColorWhite,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 5,
              top: 5,
              child: Popupwidget(student: student),
            ),
          ],
        ),
      ),
    );
  }
}
