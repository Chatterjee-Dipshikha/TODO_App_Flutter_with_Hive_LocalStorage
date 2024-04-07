import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do_list/data/database.dart';
import 'package:to_do_list/pages/util/dialog_box.dart';
import 'package:to_do_list/pages/util/todo_tile.dart';

class HomePage extends StatefulWidget {

  
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //reference the hive box
  final _myBox = Hive.box('myBox');

//const HomePage({super.key});
ToDoDatabase db=ToDoDatabase();

void initState(){
  //if this is the 1st time ever openin the app,then create default data
  if (_myBox.get("TODOLIST")==null){
    db.createInitialData();
  }else{
    //there already exists data
    db.loadData();
  }


  super.initState();
}

  //text controller
  final _controller= TextEditingController();

  

  //checkbox was tapped
  void checkBoxChanged(bool? value,int index)  {
    setState(() {
      db.toDoList[index][1]=!db.toDoList[index][1];
    });
    db.updateDatabase();

  }

  //save new task
  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text,false]);
      //to get the dialog box clean to add next todo 
      _controller.clear();
    });
//after adding new task dismis the dialog box
Navigator.of(context).pop();
db.updateDatabase();

  }

  //create new task
  void createNewTask(){
    showDialog(
      context: context, 
      builder: (context){
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: ()=>Navigator.of(context).pop(),
        );
      },
      );
  }

  //delete task
  void deleteTask(int index){
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDatabase();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 230, 239, 72),
      appBar: AppBar(
        title: Text('Seize the Day and make it Yours'),
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 79, 147, 219),
         //shadow under appbar
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
        ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index){
         return ToDoTile(
          taskName: db.toDoList[index][0],
          taskCompleted: db.toDoList[index][1],
          onChanged: (value)=> checkBoxChanged(value, index), 
          deleteFunction: (context)=> deleteTask(index),
         ); 
        }
      ),
    );
  }
}