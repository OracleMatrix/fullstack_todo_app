import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    controller.getUserData();
    return RefreshIndicator(
      onRefresh: () => controller.getUserData(),
      child: Scaffold(
        appBar: AppBar(title: const Text('T O D O'), centerTitle: true),
        body: Obx(() {
          if (controller.isLoading.value) {
            return Center(
              child: LoadingAnimationWidget.dotsTriangle(
                color: Colors.blue,
                size: 80,
              ),
            );
          }
          if (controller.userData.value.todos?.isEmpty ?? [].isNotEmpty) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.hourglass_empty,
                      size: 100,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    'You have no TODOs yet...!',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            );
          }
          if (controller.userData.value.todos == null) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.error, size: 100, color: Colors.red),
                  ),
                  Text('No data to show...!', style: TextStyle(fontSize: 18)),
                ],
              ),
            );
          }
          return ListView.builder(
            itemCount: controller.userData.value.todos?.length,
            itemBuilder: (context, index) {
              final todo = controller.userData.value.todos![index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    title: Text(todo.title ?? 'No title!'),
                    subtitle: Text(todo.description ?? 'No description!'),
                    leading: Icon(Icons.task, color: Colors.blue),
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
