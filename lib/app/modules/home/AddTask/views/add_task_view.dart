import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_task_controller.dart';

class AddTaskView extends GetView<AddTaskController> {
  const AddTaskView({super.key});
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(title: const Text('Add new TODO'), centerTitle: true),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/images/work-order.png',
                  width: Get.width,
                  height: Get.height * 0.15,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: controller.titleController.value,
                  decoration: InputDecoration(
                    hintText: 'Title',
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: controller.descriptionController.value,
                  decoration: InputDecoration(
                    hintText: 'Description',
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  validator: (value) {
                    return null;
                  },
                  maxLines: 5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 12,
                ),
                child: Obx(
                  () => DropdownButtonFormField<String>(
                    value: controller.priority.value,
                    decoration: InputDecoration(
                      labelText: 'Priority',
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'low', child: Text('Low')),
                      DropdownMenuItem(value: 'medium', child: Text('Medium')),
                      DropdownMenuItem(value: 'high', child: Text('High')),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        controller.priority.value = value;
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'save',
        backgroundColor: Colors.blue,
        onPressed: () {
          controller.addTask();
        },
        icon: Icon(Icons.add),
        label: Text('Add'),
      ),
    );
  }
}
