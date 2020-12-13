import 'dao/task_dao.dart';
import 'models/task_list.dart';
import 'models/task.dart';
import 'widgets/animated_fab.dart';
import 'widgets/task_row.dart';
import 'widgets/diagonal_clipper.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Filter Menu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainPage(),
    );
  }
}

///MainPage vars
final String urlAvatarImage =
    "https://avatars1.githubusercontent.com/u/42309863?s=400&u=5828338c2789252d24e583ede750b4c03138d25f&v=4";
const double _imageHeight = 256.0;
List<Task> _tasks = new TaskDao().tasks;

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  TaskList taskList;
  bool showOnlyCompleted;

  String getDateTime() {
    int timestamp = DateTime.now().millisecondsSinceEpoch;

    var now = new DateTime.fromMillisecondsSinceEpoch(timestamp);
    var formattedDateTime =
        DateFormat.yMMMMEEEEd(Intl.systemLocale).format(now);
    return formattedDateTime;
  }

  void _changeFilterState() {
    showOnlyCompleted = !showOnlyCompleted;
    _tasks.where((task) => !task.completed).forEach((task) {
      showOnlyCompleted
          ? taskList.removeAt(taskList.indexOf(task))
          : taskList.insert(_tasks.indexOf(task), task);
    });
  }

  @override
  void initState() {
    super.initState();
    taskList = new TaskList(_listKey, _tasks);
    showOnlyCompleted = false;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xFFF1F1F1),
      body: new Stack(
        children: [
          _buildTimeLine(),
          _buildImage(),
          _buildTopHeader(),
          _buildProfileRow(),
          _buildBottomPart(),
          _buildFab(),
        ],
      ),
    );
  }

  ///Animated Floating Action Button
  Widget _buildFab() {
    return new Positioned(
      top: _imageHeight - 100.0,
      right: -40.0,
      child: new AnimatedFab(
        onPressed: _changeFilterState,
      ),
    );
  }

  Widget _buildTimeLine() {
    return new Positioned(
      top: 0.0,
      bottom: 0.0,
      left: 32.0,
      child: new Container(
        width: 1.0,
        color: Colors.grey[400],
      ),
    );
  }

  Widget _buildImage() {
    return Positioned.fill(
      bottom: null,
      child: ClipPath(
        clipper: new DiagonalClipper(),
        child: new Image.asset(
          "assets/images/birds.jpg",
          fit: BoxFit.cover,
          height: _imageHeight,
          colorBlendMode: BlendMode.srcOver,
          color: new Color.fromARGB(120, 20, 10, 40),
        ),
      ),
    );
  }

  Widget _buildTopHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 40.0),
      child: new Row(
        children: [
          new Icon(Icons.menu, size: 32.0, color: Colors.white),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: new Text(
                "Timeline",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
          new Icon(Icons.more_horiz, size: 40.0,color: Colors.white),
        ],
      ),
    );
  }

  Widget _buildProfileRow() {
    const topOffset = _imageHeight / 2.5;
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: topOffset),
      child: new Row(
        children: <Widget>[
          new CircleAvatar(
            minRadius: 28.0,
            maxRadius: 28.0,
            backgroundImage: NetworkImage(urlAvatarImage),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                new Text(
                  "Felipe Duarte Silva",
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                new Text(
                  "Software Developer",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomPart() {
    return Padding(
      padding: const EdgeInsets.only(top: _imageHeight),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildMyTaskHeader(),
          _buildTaskList(),
        ],
      ),
    );
  }

  Widget _buildTaskList() {
    return Expanded(
      child: new AnimatedList(
        physics: BouncingScrollPhysics(),
        key: _listKey,
        initialItemCount: _tasks.length,
        itemBuilder: (context, i, animation) {
          return new TaskRow(
            task: taskList[i],
            animation: animation,
          );
        },
      ),
    );
  }

  Widget _buildMyTaskHeader() {
    return Padding(
      padding: const EdgeInsets.only(left: 64.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "My Tasks",
            style: TextStyle(fontSize: 34.0),
          ),
          Text(
            getDateTime(),
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
