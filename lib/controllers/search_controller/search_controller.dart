import 'package:get/get.dart';

class SearchControllerGetx extends GetxController {
  Rx<bool> isSearching = Rx(false);
  void toggleSearch() {
    isSearching.value = !isSearching.value;
  }
}
