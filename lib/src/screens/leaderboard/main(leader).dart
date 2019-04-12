import './diagonal_clipper.dart';
import './task.dart';
import './task_row.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new LeaderPage(),
    );
  }
}

class LeaderPage extends StatefulWidget {
  LeaderPage({Key key}) : super(key: key);

  @override
  _LeaderPageState createState() => new _LeaderPageState();
}

List<Task> tasks = [
    new Task(
      name: "Lionell",
      category: "Master",
      time: "1000",
      color: Colors.cyan[200],
      completed: true),
   new Task(
      name: "Zile",
      category: "Proficent",
      time: "200",
      color: Colors.cyan[300],
      completed: true),
 

  new Task(
      name: "Krishna",
      category: "Medium",
      time: "20",
      color: Colors.cyan[100],
      completed: true),
   new Task(
      name: "Yunyi",
      category: "Beginner",
      time: "5",//point
      color: Colors.cyan[50],
      completed: true),
  
  new Task(
      name: "B",
      category: "Idel",
      time: "0",
      color: Colors.cyan[50],
      completed: true),
];

class _LeaderPageState extends State<LeaderPage> {
  final double _imageHeight = 256.0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: new Text("Leaderboard"),
      leading: new GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: new Container(
                margin: const EdgeInsets.all(15.0),
                //TODO:exit current game button
                child: new Icon(
                  Icons.arrow_back_ios, //exit corrent game
                  color: Colors.cyan,
                  size: 30.0,
                )),
          ),),
      body: new Stack(
        children: <Widget>[
          _buildTimeline(),
          _buildIamge(),
          _buildTopHeader(),
          _buildProfileRow(),
          _buildBottomPart(),
        ],
      ),
    );
  }

  Widget _buildIamge() {
    return new ClipPath(
      clipper: new DialogonalClipper(),
      child: new Image.asset(
        'assets/images/back2.png',
        fit: BoxFit.fitHeight,
        height: _imageHeight,
        colorBlendMode: BlendMode.srcOver,
        color: new Color.fromARGB(120, 20, 10, 40),
      ),
    );
  }

  Widget _buildTopHeader() {
    return new Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 32.0),
      child: new Row(
        children: <Widget>[
          new Icon(Icons.menu, size: 28.0, color: Colors.white),
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: new Text(
                "Leader Board",
                style: new TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ),
          
        ],
      ),
    );
  }

  Widget _buildProfileRow() {
    return new Padding(
      padding: new EdgeInsets.only(left: 16.0, top: _imageHeight / 2.5),
      child: new Row(
        children: <Widget>[
          new CircleAvatar(
            minRadius: 28.0,
            maxRadius: 28.0,
            backgroundImage: new AssetImage('assets/images/avatar.jpg'),
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Text(
                  'Lionell Loh',
                  style: new TextStyle(
                      fontSize: 26.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
                new Text(
                  'Level : Master Player',
                  style: new TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomPart() {
    return new Padding(
      padding: new EdgeInsets.only(top: _imageHeight),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildMyTasksHeader(),
          _buildTasksList(),
        ],
      ),
    );
  }

  Widget _buildTasksList() {
    return new Expanded(
      child: new ListView(
        children: tasks.map((task) => new TaskRow(task: task)).toList(),
      ),
    );
  }

  Widget _buildMyTasksHeader() {
    return new Padding(
      padding: new EdgeInsets.only(left: 64.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(
            'World Ranking',
            style: new TextStyle(fontSize: 34.0),
          ),
          new Text(
            'Your point:1000',
            style: new TextStyle(color: Colors.grey, fontSize: 12.0),
          ),
          new Text(
            'Your rank:1',
            style: new TextStyle(color: Colors.grey, fontSize: 12.0),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline() {
    return new Positioned(
      top: 0.0,
      bottom: 0.0,
      left: 32.0,
      child: new Container(
        width: 1.0,
        color: Colors.grey[300],
      ),
    );
  }
}
