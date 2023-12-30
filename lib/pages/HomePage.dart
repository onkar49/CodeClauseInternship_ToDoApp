import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:untitled/data/database.dart';
import 'package:untitled/util/dialog_box.dart';
import '../util/todoTile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _myBox = Hive.box('mybox');
  ToDoDatabase db = ToDoDatabase();

  void initState(){
    if(_myBox.get("TODOLIST")==null){
      db.createInitialData();
    }else{
      db.loadData();
    }
    super.initState();
  }

  final _controller = TextEditingController();



  void checkBoxChanged(bool? value, int index){
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });
    db.updateDataBase();
  }

  void saveNewTask(){
    setState(() {
      db.todoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      }
    );
  }

  void deleteTask(int index){
  setState(() {
    db.todoList.removeAt(index);
  });
  db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green,
          centerTitle: true,
          title: const Text("TO DO")
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed : createNewTask,
        icon: Icon(Icons.add),
        label: Text("New Task"),
        backgroundColor: Colors.green,

      ),
      body: ListView.builder(
        itemCount: db.todoList.length,
        itemBuilder: (context, index) {
          return todoTile(
            taskName: db.todoList[index][0],
            taskCompleted: db.todoList[index][1],
            onChanged: (value) => checkBoxChanged(value,index),
            deleteFunction: (context) => deleteTask(index),
          );
        },

      ),
    );
  }

}
