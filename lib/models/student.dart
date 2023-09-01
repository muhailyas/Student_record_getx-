class StudentModel {
  int? id;
  String name;
  String age;
  String batch;
  String mobile;
  String email;
  String image;
  StudentModel({
    this.id,
    required this.name,
    required this.age,
    required this.batch,
    required this.mobile,
    required this.email,
    required this.image,
  });
  factory StudentModel.fromMap(Map<String, dynamic> data) {
    return StudentModel(
        id: data['id'],
        name: data['name'],
        age: data['age'],
        batch: data['batch'],
        mobile: data['mobile'],
        email: data['email'],
        image: data['image']);
  }
}
