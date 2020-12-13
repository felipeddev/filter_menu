import 'package:flutter/material.dart';

import '../models/task.dart';

class TaskDao {
  ///Database
  List<Task> _tasks = [
    new Task("Catch up with Brian", "Mobile Project", "5pm", Colors.orange, false,),
    new Task("Make new icons", "Web App", "3pm", Colors.cyan, true,),
    new Task("Design explorations", "Company Website", "2pm", Colors.pink, false,),
    new Task("Lunch with Thamires", "Grill House", "12pm", Colors.cyan, true,),
    new Task("Team Meeting", "Google Meets", "9am", Colors.cyan, true,),
    new Task("Catch up with Brian", "Mobile Project", "5pm", Colors.orange, false,),
    new Task("Make new icons", "Web App", "3pm", Colors.cyan, true,),
    new Task("Design explorations", "Company Website", "2pm", Colors.pink, false,),
    new Task("Lunch with Thamires", "Grill House", "12pm", Colors.cyan, true,),
    new Task("Team Meeting", "Google Meets", "9am", Colors.cyan, true,),

  ];

  ///Getting data from Database
  List<Task> get tasks => _tasks;
}