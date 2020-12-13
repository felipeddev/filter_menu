import 'package:filter_menu/models/task.dart';
import 'package:flutter/material.dart';

class TaskRow extends StatelessWidget {
  final Task task;
  final Animation<double> animation;

  const TaskRow({Key key, this.task, this.animation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double dotSize = 16.0;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: FadeTransition(
        opacity: animation,
        child: SizeTransition(
          sizeFactor: animation,
          child: new Row(
            children: [
              //Dot
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32.0 - dotSize / 2),
                child: new Container(
                  height: dotSize,
                  width: dotSize,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: task.color),
                ),
              ),
              //Two texts (name, category)
              new Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.name,
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Text(
                      task.category,
                      style: TextStyle(fontSize: 12.0, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              //Trailing Text (time)
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: new Text(
                  task.time,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
