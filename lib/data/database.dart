import 'package:hive/hive.dart';

class ToDoDatabase{
  List todoList =[];
  final _myBox = Hive.box('mybox');

  void createInitialData(){
    todoList = [];
  }

  void loadData(){
    todoList = _myBox.get("TODOLIST");
  }

  void updateDataBase(){
    _myBox.put("TODOLIST", todoList);
  }
}