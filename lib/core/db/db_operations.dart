import 'package:hive/hive.dart';
import 'package:na_todo/todo/models/todo_model.dart';

class DbServices {
  final Box<TodoModel> todoBox;

  DbServices({required this.todoBox});

  Future<void> saveData({required String key, required dynamic val}) async {
    await todoBox.put(key, val);
  }

  Future<dynamic> getData({required String key}) async {
    return todoBox.get(key);
  }

  Future<void> deleteData({required String key}) async {
    await todoBox.delete(key);
  }
}
