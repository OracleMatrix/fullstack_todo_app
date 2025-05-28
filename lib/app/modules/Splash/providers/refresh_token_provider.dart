import 'package:fullstack_todo_app/app/data/Constants/consts.dart';
import 'package:get/get.dart';

class RefreshTokenProvider extends GetConnect {
  Future refreshToken() async {
    try {
      final response = await get(
        '${Constants.baseUrl}/api/auth/newToken/${await Constants.storage.read(Constants.userIdKey)}',
      );
      if (response.body != null) {
        if (response.status.isOk) {
          return response.body;
        } else if (response.status.isServerError) {
          throw response.body['message'];
        } else if (response.status.isNotFound) {
          throw response.body['message'];
        } else if (response.status.isForbidden) {
          throw 'Bad request\nCheck data and try again...';
        } else {
          throw response.body['message'] ?? response.bodyString;
        }
      } else {
        throw 'Something went wrong!\nPlease try again later';
      }
    } catch (e) {
      rethrow;
    }
  }
}
