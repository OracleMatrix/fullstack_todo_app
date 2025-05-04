import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    controller.checkUser();
    return Scaffold(
      body: Center(
        child: LoadingAnimationWidget.beat(color: Colors.white, size: 80),
      ),
    );
  }
}
