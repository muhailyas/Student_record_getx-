import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/search_controller/search_controller.dart';
import '../../../../controllers/student_controller/student_controller.dart';
import '../../../../utils/colors.dart';
import '../details/student_details_screen.dart';
import '../register/register_screen.dart';
import '../widgets/text_field_widget/text_field_widget.dart';
import 'widgets/student_card/student_card.dart';

final StudentViewController studentViewController =
    Get.put(StudentViewController());
final searchController = Get.put(SearchControllerGetx());

class ScreenHome extends StatelessWidget {
  ScreenHome({super.key});
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    studentViewController.getStudents();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 5,
          backgroundColor: kThemeColorGreen,
          title: const Text(
            "CODEVAULT EDU",
            style: TextStyle(
                fontSize: 35,
                letterSpacing: -1,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          actions: [
            Obx(() {
              return IconButton(
                  onPressed: searchController.toggleSearch,
                  icon: Icon(searchController.isSearching.value
                      ? Icons.arrow_outward_sharp
                      : Icons.search));
            })
          ],
        ),
        body: Column(
          children: [
            Obx(() {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 350),
                height: searchController.isSearching.value ? 70 : 0,
                child: searchController.isSearching.value
                    ? TextFormFieldWidget(
                        hintText: 'search',
                        autoFocus: true,
                        suffixIcon: Icons.close,
                        controller: controller,
                        function: () {})
                    : null,
              );
            }),
            Expanded(
              child: GetX<StudentViewController>(
                builder: (controller) {
                  if (controller.studentList.isEmpty) {
                    return const Center(
                      child: Text(
                        "Not found",
                        style: TextStyle(color: kFontColorWhite),
                      ),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: controller.studentList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                      ),
                      itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            Get.to(StudentDetails(
                                student: controller.studentList[index]));
                          },
                          child: Student(
                            student: controller.studentList[index],
                          )),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            elevation: 10,
            child: const Icon(
              Icons.add,
              color: Colors.black,
              size: 35,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScreenRegister(),
                  ));
            }),
      ),
    );
  }
}
