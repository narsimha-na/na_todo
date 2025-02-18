import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:na_todo/core/constants/db_constants.dart';
import 'package:na_todo/core/db/db_operations.dart';
import 'package:na_todo/todo/cubit/todo_cubit.dart';
import 'package:na_todo/todo/db/todo_db_services.dart';
import 'package:na_todo/todo/models/todo_model.dart';
import 'package:na_todo/todo/todo_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter());
  Hive.registerAdapter(TimeOfDayAdapter());
  final todoBox = await Hive.openBox<List<TodoModel>>(DbConstants.dbName);
  runApp(MainApp(todoBox));
}

class MainApp extends StatelessWidget {
  const MainApp(this.todoBox, {super.key});

  final Box<List<TodoModel>> todoBox;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoCubit(
        todoDbServices: TodoDbServices(
          dbOperations: DbOperations(todoBox: todoBox),
        ),
      ),
      child: const MaterialApp(
        home: Scaffold(body: TodoPage()),
      ),
    );
  }
}
