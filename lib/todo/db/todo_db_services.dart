import 'package:flutter/material.dart';
import 'package:na_todo/core/constants/db_constants.dart';
import 'package:na_todo/core/db/db_operations.dart';
import 'package:na_todo/todo/models/todo_model.dart';

class TodoDbServices {
  final DbOperations dbOperations;
  TodoDbServices({required this.dbOperations});

  Future<List<TodoModel>> saveTodo(
      {required String message,
      required DateTime remindAtDate,
      required TimeOfDay remindAtTime}) async {
    // try {
    List<TodoModel> list =
        await dbOperations.getData(key: DbConstants.todoList) ?? [];
    int count = await dbOperations.getData(key: DbConstants.totalCount) ?? 0;
    count = count++;
    list.add(
      TodoModel(
        id: count,
        message: message,
        createdAt: DateTime.now(),
        remindAtDate: remindAtDate,
        remindAtTime: remindAtTime,
      ),
    );
    await dbOperations.saveData(key: DbConstants.todoList, val: list);
    await dbOperations.saveData(key: DbConstants.totalCount, val: count);
    return list;
    // } catch (e) {
    //   throw Exception(e.toString());
    // }
  }

  Future<List<TodoModel>> saveTodoList({required List<TodoModel> list}) async {
    try {
      await dbOperations.saveData(key: DbConstants.todoList, val: list);
      return list;
    } catch (e) {
      throw Exception("Somthing went wrong, please try again");
    }
  }

  Future<List<TodoModel>> getTodoList() async {
    try {
      List<TodoModel>? list =
          await (dbOperations.getData(key: DbConstants.todoList));
      return list ?? [];
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> deleteAll() async {
    await dbOperations.deleteData(key: DbConstants.todoList);
    await dbOperations.deleteData(key: DbConstants.totalCount);
  }
}
