import 'package:flutter/material.dart';
import 'package:na_todo/core/constants/color_constants.dart';
import 'package:na_todo/todo/widgets/create_todo_widget.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstants.greyColor,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 26, top: 56),
            child: Text(
              'NA Todo List',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ),
          ListView.builder(
            padding: EdgeInsets.fromLTRB(16, 122, 16, 70),
            shrinkWrap: true,
            itemCount: 12,
            itemBuilder: (context, index) {
              return _listItem();
            },
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 26, 26),
              child: FloatingActionButton(
                onPressed: () {
                  _openBottonSheet(context: context);
                },
                child: Icon(Icons.add_rounded),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _listItem() {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: ColorsConstants.whiteColor,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        children: [
          Column(
            children: [
              Text('25'),
              Text('Jan'),
            ],
          ),
          SizedBox(width: 20),
          Expanded(
            child: Text(
                'Janlooerammmmispsumhaiving datadafdasjdfasdljkapewiomfamdhuiopoimehakdfklj'),
          ),
          SizedBox(width: 20),
          Checkbox(value: true, onChanged: (val) {}),
        ],
      ),
    );
  }

  _openBottonSheet({
    required BuildContext context,
  }) {
    showBottomSheet(
        context: context,
        showDragHandle: true,
        builder: (context) {
          return CreateTodoWidget(
            model: null,
          );
        });
  }
}
