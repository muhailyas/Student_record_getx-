import 'package:get/get.dart';
import '../../data/database_helper.dart';
import '../../models/student.dart';

class StudentViewController extends GetxController {
  final DB _db = DB();

  RxList<StudentModel> studentList = <StudentModel>[].obs;

  Rx<String> image = Rx('');

  void setImage(String imagePath) {
    image.value = imagePath;
  }

  getStudents() async {
    List<StudentModel> list = await _db.getStudents();
    studentList.assignAll(list);
  }

  addStudent(StudentModel student) async {
    await _db.addStudent(student);
    await getStudents();
  }

  updateStudent(StudentModel student, int id) async {
    await _db.updateStudent(student, id);
    await getStudents();
  }

  deleteStudent(int id) async {
    await _db.deleteStudent(id);
    await getStudents();
  }

  searchResult(String searchQuery) async {
    List<StudentModel> list = await _db.getStudents();
    List<StudentModel> resultList = list
        .where((student) =>
            student.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
            student.age.contains(searchQuery) ||
            student.batch.contains(searchQuery) ||
            student.email.contains(searchQuery.toLowerCase()) ||
            student.mobile.contains(searchQuery))
        .toList();
    studentList.assignAll(resultList);
  }
}
