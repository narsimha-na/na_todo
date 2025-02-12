import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:na_todo/todo/db/todo_db_services.dart';
import 'package:na_todo/todo/models/todo_model.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final TodoDbServices dbServices;

  TodoCubit({required this.dbServices}) : super(TodoInitialState());

  void saveTodo({required TodoModel data}) {
    emit(TodoLoading(loading: true));

    emit(TodoValue(todoList: dbServices.saveTodoList(val: data)));
  }

  void getTodos() {
    emit(TodoValue(todoList: dbServices.getTodoList()));
  }

  void deleteTodo() {
    emit(TodoInitialState());
  }

  void checkBox({required bool val, required int id}) async {
    List<TodoModel> _list = await dbServices.getTodoList();
    for (var item in _list) {
      if (item.id == id) {
        item.isChecked = val;
        emit(TodoSucess());
        return;
      }
    }
    emit(TodoFailure());
  }
}
