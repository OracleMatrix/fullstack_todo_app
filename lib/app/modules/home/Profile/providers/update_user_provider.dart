import 'package:fullstack_todo_app/app/data/Constants/consts.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UpdateUserProvider extends GetConnect {
  Future updateUser(Map<String, dynamic> data) async {
    try {
      final response = await put(
        '${Constants.baseUrl}/api/users/${await GetStorage().read(Constants.userIdKey)}',
        data,
        headers: {
          'authentication': await GetStorage().read(Constants.tokenKey),
        },
      );
      if (response.body != null) {
        if (response.status.isOk) {
          return response.body['message'];
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
