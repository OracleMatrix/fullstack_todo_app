import 'package:fullstack_todo_app/app/data/Constants/consts.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MarkAsDoneProvider extends GetConnect {
  Future markAsCompleted(int todoId) async {
    try {
      final response = await patch(
        '${Constants.baseUrl}/api/todos/$todoId/complete',
        {},
        headers: {
          'authentication': await GetStorage().read(Constants.tokenKey),
        },
      );
      if (response.body != null) {
        if (response.status.isOk) {
          return response.body;
        } else if (response.status.isServerError) {
          throw 'Server is not reachable\nPlease try again later';
        } else if (response.status.isNotFound) {
          throw 'Not Found!';
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
