import 'package:hive_ce_flutter/adapters.dart';

class toDoDataBase {

  List toDoList = [];

  // refrence our box
  final _myBox = Hive.box('myBox');


  // run if first time ever run the app 
  void createInitialData() {
    toDoList = [
      ["Make Tutorial", false, DateTime.now()]
    ];
  }

  // load data base
  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }

  //update database
  void updateDataBase() {
    _myBox.put("TODOLIST", toDoList);
  }

}

// recent deleted
class recentdel{
  List deletedList = [];

  final _recentDeleted = Hive.box('recentDeleted');

  //set duration for delete timer
  final Duration autoDeleteDuration = Duration(days: 3);

  
  void createInitialData() {
    // A deleted list should start empty
    deletedList = [];
    updateDataBase(); // Save the initial state
  }
  // Load the list from Hive
  void loadData() {
    // Ensure you use the correct key for the deleted list data
    deletedList = _recentDeleted.get("DELETEDLIST") ?? [];

    List<dynamic> newList = [];
    DateTime now = DateTime.now();

    for (var item in deletedList) {
      if (item.length > 3 && item[3] is DateTime) {
        DateTime deletionDate = item[3] as DateTime;

        if (now.difference(deletionDate) < autoDeleteDuration ) {
          newList.add(item);
        } else {
          print('Auto-delted expired Task: ${item[0]}');
        }
      } else {
        newList.add(item);
      }
    }

    deletedList = newList;
    updateDataBase();
    
  }

  // Save the current list back to Hive
  void updateDataBase() {
    _recentDeleted.put("DELETEDLIST", deletedList);
  }

}