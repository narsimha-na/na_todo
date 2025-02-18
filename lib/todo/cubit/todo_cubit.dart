import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:na_todo/todo/db/todo_db_services.dart';
import 'package:na_todo/todo/models/todo_model.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final TodoDbServices todoDbServices;

  TodoCubit({required this.todoDbServices}) : super(TodoInitialState());

  void saveTodo({
    required String message,
    required DateTime date,
    required TimeOfDay time,
  }) async {
    emit(TodoLoading(loading: true));
    if (message.isEmpty) {
      emit(TodoFailure(message: "enter your todo message"));
    }

    // try {
    List<TodoModel> list = await todoDbServices.saveTodo(
      message: message,
      remindAtDate: date,
      remindAtTime: time,
    );

    emit(TodoValue(todoList: list));
    // } catch (e) {
    //   emit(TodoFailure(message: e.toString()));
    // }
  }

  void getTodos() async {
    emit(TodoLoading(loading: true));
    try {
      List<TodoModel> list = await todoDbServices.getTodoList();

      emit(TodoValue(todoList: list));
    } catch (e) {
      emit(TodoFailure(message: e.toString()));
    }
  }

  void deleteTodo() async {
    try {
      await todoDbServices.deleteAll();
      emit(TodoValue(todoList: []));
    } catch (e) {
      emit(TodoFailure(message: e.toString()));
    }
  }

  void checkBox({required bool val, required int id}) async {
    try {
      List<TodoModel> list = await todoDbServices.getTodoList();
      for (var item in list) {
        if (item.id == id) {
          item.isChecked = val;
          return;
        }
      }

      todoDbServices.saveTodoList(list: list);
      TodoValue(todoList: list);
    } catch (e) {
      emit(TodoFailure(message: e.toString()));
    }
  }
}
