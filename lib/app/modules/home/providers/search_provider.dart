import 'package:fullstack_todo_app/app/data/Constants/consts.dart';
import 'package:fullstack_todo_app/app/modules/home/Models/get_todos_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SearchProvider extends GetConnect {
  Future<List<GetTodosModel>?> searchTodos(String query) async {
    try {
      final response = await get(
        '${Constants.baseUrl}/api/todos/search',
        headers: {'authentication': '${GetStorage().read(Constants.tokenKey)}'},
        query: {
          'title': query,
          'userId': GetStorage().read(Constants.userIdKey).toString(),
        },
      );
      if (response.body != null) {
        if (response.status.isOk) {
          return getTodosModelFromJson(response.bodyString!);
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
