import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:to_doapp/data/database.dart';
import 'package:to_doapp/util/createtask.dart';
import 'package:to_doapp/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});


  
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference the hive box
   final _myBox = Hive.box('myBox');
   final _recentDeleted = Hive.box('recentDeleted');
   
   
    toDoDataBase db = toDoDataBase();
    recentdel rd = recentdel();

    

    @override
  void initState() {
    const String firstTimeKey = 'FIRST_TIME_OPEN';

try {
    // check first time key
    bool isFirstTime = _myBox.get(firstTimeKey) ?? true;

    if (isFirstTime) {
      // First time use true
      db.createInitialData();

      //change isfirsttime state
      _myBox.put(firstTimeKey, false);

    }
    else {
      //if not first time load data
      db.loadData();

    }

  } catch (e) {
    // If corruption is detected during load, reset the main box and recreate data
    _myBox.clear();
    db.createInitialData();
    print('Corrupted TODOLIST data detected and reset.');
  }

  // Load the deleted list data
    rd.loadData();

    super.initState();
  }

  // text controller
  final _controller = TextEditingController();



  //save method
  void saveNewTask() {
    setState(() {
      db.toDoList.add([
        _controller.text,
        false,
        DateTime.now()
         ]);
      
      Navigator.of(context).pop();
      _controller.clear();
      showDialog(
                      context: context,
                      builder: (context) {
                        Future.delayed(Duration(seconds: 1), () {
                          Navigator.of(context).pop(true);
                        });
                        return AlertDialog(
                          title: Text('Added'),
                          backgroundColor:  Color.fromARGB(100, 158, 180, 183),
                        );
                      });
    });
        db.updateDataBase();


  }


  void checkboxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }


  //create new task
  void createNewTask(){
    showDialog(context: context
    , builder: (context){
      return DialogBox(
        controller: _controller,
        onSave: saveNewTask,
        onCancel: () => Navigator.of(context).pop(),
      );
    });
    db.updateDataBase();
  }

  //delete task
  void deleteTask(int index) {
    setState(() {
      List<dynamic> taskToDelete = db.toDoList[index];
      rd.deletedList.add(taskToDelete);
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
    rd.updateDataBase();

  }


  //theme mode
  void mode(){  
    String mode = '';

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Color.fromARGB(255, 25, 25, 25),
      appBar: AppBar(
        
          
        backgroundColor: Color.fromARGB(255, 0, 0, 0),

        centerTitle: true,
        
        title: Text(
            'To Do',
            style: TextStyle(
              color: const Color.fromARGB(255, 224, 224, 224),
              fontWeight: FontWeight.bold,
              fontSize: 24,
              ), 
          
          ),
          
        
        leading:  IconButton(
          icon: Icon(
            Icons.delete,
            color: Colors.white,
            ),
          onPressed:  () async {
             await Navigator.pushNamed(context, '/recentdel');
        
             setState(() {
               db.loadData();
             });
          },
          
          ),

        

          
      ),

      
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        backgroundColor: Color.fromARGB(255, 158, 180, 183),
        child: Icon(Icons.add),
      ),

      
      body: ListView.builder(
        itemCount: db.toDoList.length,
        
        itemBuilder: (context, index) {
          DateTime? date = db.toDoList[index].length > 2
          ? db.toDoList[index][2] as DateTime : null;
          return TodoTile(
          taskName: db.toDoList[index][0],
          taskComplete: db.toDoList[index][1],
          onChanged: (value) => checkboxChanged(value, index),
          deleteAction: (context) => deleteTask(index),
          taskdate: date,
          );
        },


      )
    );
  }
}