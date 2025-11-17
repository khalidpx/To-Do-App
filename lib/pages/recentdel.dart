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
void didChangeDependencies() {
    // 1. Ensure db loads ALL existing tasks from the main box 
    //    *every time* the screen is visible.
    try {
        db.loadData();
    } catch (e) {
        // Handle potential corruption by resetting the box
        Hive.box('myBox').clear();
        db.createInitialData(); 
    }

    // 2. Load deleted list data
    try {
        rd.loadData();
    } catch (e) {
        _recentDeleted.clear();
        rd.createInitialData();
    }
    
    // Call setState to rebuild the list view
    setState(() {}); 
    
    super.didChangeDependencies();
}

void restoreTask(int index) {
    setState(() {
        List<dynamic> taskToRestore = rd.deletedList[index];
        
        // This task is being added to the list loaded above.
        db.toDoList.add(taskToRestore);
        
        rd.deletedList.removeAt(index);
    });
    
    // This now saves the fully loaded list (old tasks + restored task).
    db.updateDataBase();
    rd.updateDataBase();
}
// ...
    @override
  void initState() {
    super.initState();
  }

  //RestoreAction
  void deleteTask(int index) {
    setState(() {
      rd.deletedList.removeAt(index);
    });
    rd.updateDataBase();

  }

  //return task
  void RestoreTask(int index) {
    setState(() {
      List<dynamic> taskToRestore = rd.deletedList[index];
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