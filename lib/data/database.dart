import 'package:hive/hive.dart';

class ToDoDatabase{
  List toDoList=[];
  //reference the box
  final _myBox=Hive.box('myBox');

  
  //run the method if this is the 1st time ever opening this app
  void createInitialData(){
    toDoList=[
      ["Make Tutorial",false],
      ["Do Exercise",false],
    ];
  }

  //load the data from database
  void loadData(){
    toDoList=_myBox.get("TODOLIST");

  }

  //update the database
  void updateDatabase(){
    _myBox.put("TODOLIST", toDoList);

  }
  
}