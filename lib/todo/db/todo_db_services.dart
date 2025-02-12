import 'package:hive/hive.dart';
import 'package:na_todo/core/constants/db_constants.dart';
import 'package:na_todo/core/db/db_operations.dart';
import 'package:na_todo/todo/models/todo_model.dart';

class TodoDbServices {
  final DbServices dbServices;
  TodoDbServices({required this.dbServices});

  Future<List<TodoModel>> saveTodoList({required TodoModel val}) async {
    List<TodoModel> _list = await dbServices.getData(key: DbConstants.todoList);
    _list.add(val);
    await dbServices.saveData(key: DbConstants.todoList, val: _list);
    return _list;
  }

  Future<List<TodoModel>> getTodoList() async {
    return await dbServices.getData(key: DbConstants.todoList);
  }

  Future<void> deleteTodoList() async {
    await dbServices.deleteData(key: DbConstants.todoList);
  }
}
