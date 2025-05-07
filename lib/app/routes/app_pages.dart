import 'package:get/get.dart';

import '../modules/Authentication/bindings/authentication_binding.dart';
import '../modules/Authentication/views/authentication_view.dart';
import '../modules/Splash/bindings/splash_binding.dart';
import '../modules/Splash/views/splash_view.dart';
import '../modules/home/AddTask/bindings/add_task_binding.dart';
import '../modules/home/AddTask/views/add_task_view.dart';
import '../modules/home/EditTask/bindings/edit_task_binding.dart';
import '../modules/home/EditTask/views/edit_task_view.dart';
import '../modules/home/Profile/bindings/profile_binding.dart';
import '../modules/home/Profile/views/profile_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      children: [
        GetPage(
          name: _Paths.EDIT_TASK,
          page: () => const EditTaskView(),
          binding: EditTaskBinding(),
        ),
        GetPage(
          name: _Paths.ADD_TASK,
          page: () => const AddTaskView(),
          binding: AddTaskBinding(),
        ),
        GetPage(
          name: _Paths.PROFILE,
          page: () => const ProfileView(),
          binding: ProfileBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.AUTHENTICATION,
      page: () => const AuthenticationView(),
      binding: AuthenticationBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
  ];
}
