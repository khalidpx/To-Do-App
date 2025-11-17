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

  
  void createInitialData() {
    // A deleted list should start empty
    deletedList = [];
    updateDataBase(); // Save the initial state
  }
  // Load the list from Hive
  void loadData() {
    // Ensure you use the correct key for the deleted list data
    deletedList = _recentDeleted.get("DELETEDLIST") ?? [];
    
  }

  // Save the current list back to Hive
  void updateDataBase() {
    _recentDeleted.put("DELETEDLIST", deletedList);
  }

}