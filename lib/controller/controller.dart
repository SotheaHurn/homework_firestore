import 'package:get/get.dart';
import 'package:hw_grid_view_2/model/model.dart';

class Controller extends GetxController {
  final imageURL = ''.obs;
  final list = <AddPhotoDemo>[].obs;

  void setURL(String url) {
    imageURL.value = url;
  }

  void addList(AddPhotoDemo addPhoto) {
    list.add(addPhoto);
  }

  void deletList(int index) {
    list.removeAt(index);
  }
}
