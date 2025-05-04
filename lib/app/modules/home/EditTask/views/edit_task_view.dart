import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_task_controller.dart';

class EditTaskView extends GetView<EditTaskController> {
  const EditTaskView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EditTaskView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'EditTaskView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
