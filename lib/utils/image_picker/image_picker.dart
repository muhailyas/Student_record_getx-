import 'package:image_picker/image_picker.dart';

Future<XFile> imagePicker() async {
  final picker = ImagePicker();
  try {
    final XFile? image =
        await picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      throw Exception("No image was selected.");
    }
    return image;
  } catch (e) {
    throw Exception(e);
  }
}
