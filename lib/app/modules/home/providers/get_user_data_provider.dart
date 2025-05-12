import 'package:fullstack_todo_app/app/data/Constants/consts.dart';
import 'package:fullstack_todo_app/app/modules/home/Models/get_user_data_model.dart';
import 'package:get/get.dart';

class GetUserDataProvider extends GetConnect {
  Future<GetUserDataModel?> getUserData() async {
    try {
      final response = await get(
        '${Constants.baseUrl}/api/users/${await Constants.storage.read(Constants.userIdKey)}',
        headers: {
          'authentication': await Constants.storage.read(Constants.tokenKey),
        },
      );
      if (response.body != null) {
        if (response.status.isOk) {
          return getUserDataModelFromJson(response.bodyString!);
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
