import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../models/student.dart';
import '../../../../utils/colors.dart';
import '../../../update/student_update_screen.dart';
import '../../home_screen.dart';

class Popupwidget extends StatelessWidget {
  const Popupwidget({super.key, required this.student});
  final StudentModel student;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      color: kThemeColorGreen,
      elevation: 10,
      icon: const Icon(
        Icons.more_vert_outlined,
        color: Colors.white,
      ),
      onSelected: (value) async {
        if (value == 'edit') {
          Get.to(ScreenEditStduent(student: student));
        } else if (value == 'delete') {
          await studentViewController.deleteStudent(student.id!);
          Get.snackbar(
            "Delete",
            'Deleted Successfully',
            snackPosition: SnackPosition.BOTTOM,
            colorText: kFontColorWhite,
            backgroundColor: Colors.red,
          );
        }
      },
      itemBuilder: (context) {
        return [
          const PopupMenuItem<String>(
            value: 'edit',
            child: ListTile(
              leading: Icon(
                Icons.edit,
                color: kThemeWhite,
              ),
              title: Text(
                'Edit',
                style: TextStyle(color: kThemeWhite),
              ),
            ),
          ),
          const PopupMenuItem<String>(
            value: 'delete',
            child: ListTile(
              leading: Icon(
                Icons.delete,
                color: kThemeWhite,
              ),
              title: Text(
                'delete',
                style: TextStyle(color: kThemeWhite),
              ),
            ),
          ),
        ];
      },
    );
  }
}
