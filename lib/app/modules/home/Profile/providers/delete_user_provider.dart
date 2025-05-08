import 'package:fullstack_todo_app/app/data/Constants/consts.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DeleteUserProvider extends GetConnect {
  Future deleteUser() async {
    try {
      final response = await delete(
        '${Constants.baseUrl}/api/users/${await GetStorage().read(Constants.userIdKey)}',
        headers: {
          'authentication': await GetStorage().read(Constants.tokenKey),
        },
      );
      if (response.body != null) {
        if (response.status.isOk) {
          throw response.body['message'];
        } else if (response.status.isServerError) {
          throw response.body['message'];
        } else if (response.status.isNotFound) {
          throw response.body['message'];
        } else if (response.status.isForbidden) {
          throw 'Bad request\nCheck data and try again...';
        } else {
          throw response.body['message'];
        }
      } else {
        throw 'Something went wrong!\nPlease try again later';
      }
    } catch (e) {
      rethrow;
    }
  }
}
