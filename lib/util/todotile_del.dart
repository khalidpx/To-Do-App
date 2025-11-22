import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// ignore: must_be_immutable
class TodotileDel extends StatelessWidget {
  TodotileDel({
    super.key,
    required this.taskName,
    required this.taskComplete,
    required this.deleteAction,
    required this.RestoreAction

    });

  final String taskName;
  final bool taskComplete;
  Function(BuildContext)? deleteAction;
  Function(BuildContext)? RestoreAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
      child: Slidable(
        endActionPane: ActionPane(
        motion: StretchMotion(), 

        children: [SlidableAction(
        onPressed: RestoreAction,
        label: 'Restore',
        icon: Icons.restore,
        backgroundColor:  Color.fromARGB(255, 168, 244, 54),
        borderRadius: BorderRadius.circular(50),
        
        ),
        SizedBox(width: 10)
        ,
        SlidableAction(
        onPressed: deleteAction,
        label: 'Delete',
        icon: Icons.delete,
        backgroundColor:  Colors.red,
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
              )
            ],
          ),
        ),
      ),

    );
  }
}