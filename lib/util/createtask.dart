import 'package:flutter/material.dart';
import 'package:to_doapp/util/mybutton.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;


  DialogBox({
    super.key, required this.controller,
    required this.onCancel,
    required this.onSave
});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      
        backgroundColor: Color.fromARGB(255, 62, 62, 62),
        content: SizedBox(
          height: 150,

          child: Column(
          
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          
          children: [
            Expanded(
              
              child: TextField(
                autofocus: true,
                
                controller: controller,
                style: TextStyle(
                  color: Colors.white
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Add New Task',
                  hintStyle: TextStyle(
                    color: Colors.grey
                  )
                                   
                ),
                
              ),
            ),
        
            //Buttons save + cancel
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              
              children: [
              //save
              MyButton(
                text: "Save", 
                onPressed: onSave,
                ),
        
              SizedBox(width: 30),
              //cancel
              MyButton(text: "Cancel", onPressed: onCancel)
            ],
            )
          ],
        )
        ),
      
      
    );
  }
}