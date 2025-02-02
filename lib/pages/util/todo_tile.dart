import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteFunction;

  const ToDoTile({
    super.key, 
    required this.taskName, 
    required this.taskCompleted, 
    required this.onChanged,
    required this.deleteFunction
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 25,right: 25,top: 25),
  
        
        child: Slidable(
          endActionPane: ActionPane(
            motion: StretchMotion(), 
            children: [
              SlidableAction(
                onPressed: deleteFunction,
                icon: Icons.delete,
                backgroundColor: Colors.red.shade300,
                borderRadius: BorderRadius.circular(12),
                )
            ],
            ),
          child: Container(
            child:  Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [ 
                  //checkbox
                  Checkbox(value: taskCompleted, 
                  onChanged: onChanged,
                  activeColor: Color.fromARGB(255, 38, 104, 204),),
              
                  Text(taskName,
                  style: TextStyle(
                    decoration: taskCompleted
                    ? TextDecoration.lineThrough
                    :TextDecoration.none),),
                ],
              ),
            ),
            decoration: BoxDecoration(color: Color.fromARGB(255, 201, 203, 54),
            borderRadius: BorderRadius.circular(12)),
          ),
        ),
      );
  }
}