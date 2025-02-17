import 'package:hive/hive.dart';
import 'package:na_todo/core/constants/db_constants.dart';
import 'package:na_todo/core/db/db_operations.dart';
import 'package:na_todo/todo/models/todo_model.dart';

class TodoDbServices {
  final DbServices dbServices;
  TodoDbServices({required this.dbServices});

  Future<List<TodoModel>> saveTodo({required TodoModel val}) async {
    try {
      List<TodoModel> list =
          await dbServices.getData(key: DbConstants.todoList);
      list.add(val);
      await dbServices.saveData(key: DbConstants.todoList, val: list);
      return list;
    } catch (e) {
      throw Exception("Somthing went wrong, please try again");
    }
  }

  Future<List<TodoModel>> saveTodoList({required List<TodoModel> list}) async {
    try {
      await dbServices.saveData(key: DbConstants.todoList, val: list);
      return list;
    } catch (e) {
      throw Exception("Somthing went wrong, please try again");
    }
  }

  Future<List<TodoModel>> getTodoList() async {
    return await dbServices.getData(key: DbConstants.todoList);
  }

  Future<void> deleteTodoList() async {
    await dbServices.deleteData(key: DbConstants.todoList);
  }
}
