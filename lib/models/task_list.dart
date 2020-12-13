import 'package:filter_menu/widgets/task_row.dart';
import 'package:flutter/material.dart';

import 'task.dart';

Duration _kDuration = new Duration(milliseconds: 150);

class TaskList {
  final GlobalKey<AnimatedListState> listKey;
  final List<Task> items;

  TaskList(this.listKey, items) : this.items = new List.of(items);

  AnimatedListState get _animatedList => listKey.currentState;

  void insert(int index, Task item) {
    items.insert(index, item);
    _animatedList.insertItem(index, duration: _kDuration);
  }

  Task removeAt(int index) {
    final Task removedItem = items.removeAt(index);
    if (removedItem != null) {
      _animatedList.removeItem(
        index,
        (context, animation) => new TaskRow(
          task: removedItem,
          animation: animation,
        ),
        duration: new Duration(
            //Duration grows based on widget's position in the list
            milliseconds: (_kDuration.inMilliseconds +
                    _kDuration.inMilliseconds * (index / length))
                .toInt()),
      );
    }
    return removedItem;
  }

  int get length => items.length;

  Task operator [](int index) => items[index];

  int indexOf(Task item) => items.indexOf(item);
}
