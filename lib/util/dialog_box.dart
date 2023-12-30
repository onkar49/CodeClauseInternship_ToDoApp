import 'package:flutter/material.dart';
import 'package:untitled/util/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

    DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel
});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.green,
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          TextField(
            controller: controller,
            decoration: InputDecoration(border: OutlineInputBorder(),
              hintText: "add a new task"
            ),
          ),
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            myButton(text: "Save", onPressed: onSave ),
            myButton(text: "Cancel", onPressed: onCancel   ),
          ],),
        ],),
      ),
    );
  }
}
