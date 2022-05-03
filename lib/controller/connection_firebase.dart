import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:hw_grid_view_2/model/model.dart';
// ignore: library_prefixes
import 'package:path/path.dart' as Path;

import 'controller.dart';

class ConnectionFB {
  static Future uploadImage(String name, PlatformFile pickedImage) async {
    final Controller controller = Get.find();
    final path = 'files/$name';
    final file = File(pickedImage.path!);
    final ref = FirebaseStorage.instance.ref().child(path);
    ref.putFile(file);

    final snapshot = await ref.putFile(file).whenComplete(() {});
    final urlDowload = await snapshot.ref.getDownloadURL();
    controller.setURL(urlDowload);
  }

  static Future<void> deleteImage(String url) async {
    var fileURL =
        Uri.decodeFull(Path.basename(url)).replaceAll(RegExp(r'(\?alt).*'), '');

    FirebaseStorage.instance.ref().child(fileURL).delete();
  }

  static Future insertData({
    required String name,
    required String imageURL,
  }) async {
    final docProduct =
        FirebaseFirestore.instance.collection('addPhotoDemo').doc();
    final product =
        AddPhotoDemo(id: docProduct.id, name: name, imageURL: imageURL);
    final json = product.toJson();
    await docProduct.set(json);
    Get.put(Controller()).list.add(product);
  }

  static Stream<List<AddPhotoDemo>> getData() => FirebaseFirestore.instance
      .collection('addPhotoDemo')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => AddPhotoDemo.fromJson(doc.data()))
          .toList());

  static void deleteData({required String id}) =>
      FirebaseFirestore.instance.collection('addPhotoDemo').doc(id).delete();
}
