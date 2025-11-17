import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class TodoTile extends StatelessWidget {
  TodoTile({
    super.key,
    required this.taskName,
    required this.taskComplete,
    required this.onChanged,
    required this.deleteAction,
    required this.taskdate


    });

  final String taskName;
  final bool taskComplete;
  final DateTime? taskdate;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: Slidable(
        endActionPane: ActionPane(
        motion: StretchMotion(), 

        children: [SlidableAction(
        
        onPressed: deleteAction,
        label: 'Delete',
        icon: Icons.delete, 

        backgroundColor: Colors.red,
        
        borderRadius: BorderRadius.circular(50),
        
        
        
        )
        ]
        ),
        
        
        child: Container(
          margin: EdgeInsets.only(right: 5),
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 158, 180, 183),
            borderRadius: BorderRadius.circular(50),
          ),
          
          child: Row(
            children: [
              Checkbox(value: taskComplete, onChanged: onChanged),
              Expanded(
                child: Text(taskName, 
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  decoration: taskComplete? TextDecoration.lineThrough : TextDecoration.none
                ),
                ),
                
              ),
              if (taskdate != null)
                Text(
                  // You need the intl package for this format, otherwise use .toString()
                  DateFormat('h:mm a').format(taskdate!),
                  style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                ),
            ],
          ),
        ),
      ),

    );
  }
}