import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hw_grid_view_2/column_view.dart';
import 'package:hw_grid_view_2/controller/connection_firebase.dart';
import 'package:hw_grid_view_2/controller/controller.dart';
import 'package:hw_grid_view_2/model/model.dart';
import 'package:hw_grid_view_2/page/add_photo_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Controller());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Photo Demo'),
        actions: [
          IconButton(
            onPressed: () => Get.to(() => const AddPhotoPage()),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: FutureBuilder<List<AddPhotoDemo>>(
        future: ConnectionFB.getData().first,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            controller.list.value = snapshot.data!;
            return Obx(
              () {
                if (controller.list.isEmpty) {
                  return const Center(
                    child: Text(
                      'Null',
                      style: TextStyle(fontSize: 50, color: Colors.grey),
                    ),
                  );
                } else {
                  return GridView.builder(
                    itemCount: controller.list.length,
                    padding: const EdgeInsets.all(15),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                    itemBuilder: (BuildContext context, int index) =>
                        ColumnView(
                            onClickedDelete: () {
                              ConnectionFB.deleteData(
                                  id: controller.list[index].id);
                              ConnectionFB.deleteImage(
                                  controller.list[index].imageURL);
                              controller.deletList(index);
                            },
                            name: controller.list[index].name,
                            url: controller.list[index].imageURL),
                  );
                }
              },
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Icon(
                Icons.info,
                color: Colors.red,
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
