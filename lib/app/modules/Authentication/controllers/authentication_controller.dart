import 'package:fullstack_todo_app/app/data/Constants/consts.dart';
import 'package:fullstack_todo_app/app/modules/Authentication/Models/user_info_model.dart';
import 'package:fullstack_todo_app/app/modules/Authentication/providers/login_provider.dart';
import 'package:fullstack_todo_app/app/modules/Authentication/providers/register_provider.dart';
import 'package:fullstack_todo_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

class AuthenticationController extends GetxController {
  var _registerProvider = RegisterProvider();
  get registerProvider => _registerProvider;

  set registerProvider(var value) => _registerProvider = value;

  var _loginProvider = LoginProvider();
  get loginProvider => _loginProvider;

  set loginProvider(var value) => _loginProvider = value;

  var isLoading = false.obs;

  var userInfo = UserInfoModel().obs;

  Future<String?> register(
    String username,
    String email,
    String password,
  ) async {
    try {
      isLoading.value = true;
      final data = {'username': username, 'email': email, 'password': password};
      final response = await _registerProvider.register(data);
      if (response != null) {
        userInfo.value = response;
        Constants.storage.write(Constants.userIdKey, userInfo.value.user!.id);
        Constants.storage.write(
          Constants.userIdKey,
          userInfo.value.user!.username,
        );
        Constants.storage.write(Constants.userIdKey, userInfo.value.token);
        Get.offAllNamed(Routes.HOME);
        return null;
      } else {
        return 'Registration failed';
      }
    } catch (e) {
      return e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<String?> login(String email, String password) async {
    try {
      isLoading.value = true;
      final data = {'email': email, 'password': password};
      final response = await _loginProvider.login(data);
      if (response != null) {
        userInfo.value = response;
        Constants.storage.write(Constants.userIdKey, userInfo.value.user!.id);
        Constants.storage.write(
          Constants.userIdKey,
          userInfo.value.user!.username,
        );
        Constants.storage.write(Constants.userIdKey, userInfo.value.token);
        Get.offAllNamed(Routes.HOME);
        return null;
      } else {
        return 'Login failed';
      }
    } catch (e) {
      return e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
