import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hw_grid_view_2/controller/connection_firebase.dart';
import 'package:hw_grid_view_2/controller/controller.dart';
import 'package:hw_grid_view_2/widgets/button_widget.dart';
import 'package:hw_grid_view_2/widgets/pick_image_widget.dart';
import 'package:hw_grid_view_2/widgets/textfield.dart';

class AddPhotoPage extends StatefulWidget {
  const AddPhotoPage({Key? key}) : super(key: key);

  @override
  State<AddPhotoPage> createState() => _AddPhotoPageState();
}

class _AddPhotoPageState extends State<AddPhotoPage> {
  final Controller controller = Get.find();
  final textController = TextEditingController();
  PlatformFile? pickedImage;

  Future selectImage() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickedImage = result.files.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Photo'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(height: 30),
          PickImage(
            onClicked: selectImage,
            pickedImage: pickedImage,
          ),
          const SizedBox(height: 30),
          TextFieldWidget(controller: textController),
          const SizedBox(height: 50),
          ButtonWidget(
            onClicked: () {
              if (pickedImage == null) {
                Get.snackbar('Error', 'Please upload a image',
                    duration: const Duration(seconds: 3),
                    showProgressIndicator: false,
                    barBlur: 110,
                    backgroundColor: Colors.red,
                    snackPosition: SnackPosition.BOTTOM,
                    overlayBlur: 0.1);
              } else {
                ConnectionFB.uploadImage(
                        textController.text.trim(), pickedImage!)
                    .whenComplete(() => ConnectionFB.insertData(
                        name: textController.text.trim(),
                        imageURL: controller.imageURL.value));
                Get.snackbar('Saving', 'Your data has been saved to Firebase',
                    duration: const Duration(seconds: 3),
                    showProgressIndicator: true,
                    barBlur: 110,
                    snackPosition: SnackPosition.TOP,
                    overlayBlur: 0.1);
                Future.delayed(
                    const Duration(seconds: 3), () => Navigator.pop(context));
              }
            },
            name: 'Save',
          ),
        ],
      ),
    );
  }
}
