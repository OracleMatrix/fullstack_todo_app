import 'package:fullstack_todo_app/app/data/Constants/consts.dart';
import 'package:fullstack_todo_app/app/modules/home/Profile/Models/get_user_profile_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class GetUserProfileProvider extends GetConnect {
  Future<UserProfileModel?> getUserProfile() async {
    try {
      final response = await get(
        '${Constants.baseUrl}/api/users/userProfile/${await GetStorage().read(Constants.userIdKey)}',
        headers: {
          'authentication': await GetStorage().read(Constants.tokenKey),
        },
      );
      if (response.body != null) {
        if (response.status.isOk) {
          return userProfileModelFromJson(response.bodyString!);
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
