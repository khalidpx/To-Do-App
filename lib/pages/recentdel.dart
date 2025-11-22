import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:to_doapp/data/database.dart';

import 'package:to_doapp/util/todotile_del.dart';

class Recentdel extends StatefulWidget {
  const Recentdel({super.key});

  @override
  State<Recentdel> createState() => _HomePageState();
}

class _HomePageState extends State<Recentdel> {
  // reference the hive box
   final _recentDeleted = Hive.box('recentDeleted');
    toDoDataBase db = toDoDataBase();
    recentdel rd = recentdel();
    
@override
  // Inside class _HomePageState extends State<Recentdel> { ...

@override
  void initState() {
    try {
      rd.loadData();
    } catch (e) {
      _recentDeleted.clear();
      rd.createInitialData();
    }
    super.initState();
  }


void restoreTask(int index) {
    setState(() {
        List<dynamic> taskToRestore = rd.deletedList[index];

        taskToRestore.remove(taskToRestore[3]);
        
        // This task is being added to the list loaded above.
        db.toDoList.add(taskToRestore);
        
        rd.deletedList.removeAt(index);
    });
    
    // This now saves the fully loaded list (old tasks + restored task).
    db.updateDataBase();
    rd.updateDataBase();

    //return to home page after restoration
    Navigator.pop(context);
}
// ...
    @override

  //RestoreAction
  void deleteTask(int index) {
    setState(() {
      rd.deletedList.removeAt(index);
    });
    rd.updateDataBase();

  }

  //return task
  // ignore: non_constant_identifier_names
  void RestoreTask(int index) {
    setState(() {
      List<dynamic> taskToRestore = rd.deletedList[index];
      if (taskToRestore.length > 3) {
            taskToRestore.removeAt(3); 
        }
      db.toDoList.add(taskToRestore);
      rd.deletedList.removeAt(index);
    });
    db.updateDataBase();
    rd.updateDataBase();

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Color.fromARGB(255, 25, 25, 25),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
            'Recently Deleted',
            style: TextStyle(
              color: const Color.fromARGB(255, 224, 224, 224),
              fontWeight: FontWeight.bold,
              fontSize: 24,
              ), 
          
          ),
        ),
      


      body: ListView.builder(
        itemCount: rd.deletedList.length,
        itemBuilder: (context, index) {
          if (rd.deletedList[index].length < 2) {
            return ListTile(title: Text('Invalid Task Data'));
          }
          return TodotileDel(
          taskName: rd.deletedList[index][0],
          taskComplete: rd.deletedList[index][1],
          deleteAction: (context) => deleteTask(index),
          RestoreAction: (context) => RestoreTask(index),
          );
        },


      )
    );
  }
}