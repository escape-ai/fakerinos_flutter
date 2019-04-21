import './diagonal_clipper.dart';
import './task.dart';
import './player_row.dart';
import 'package:flutter/material.dart';
import '../sharedPreferencesHelper.dart';
import 'package:http/http.dart'; 
import 'dart:convert';
import 'dart:io';
import './player.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


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

// List<Task> tasks = [
//     new Task(
//       name: "Lionell",
//       category: "Master",
//       time: "1000",
//       color: Colors.cyan[200],
//       completed: true),
//    new Task(
//       name: "Zile",
//       category: "Proficent",
//       time: "200",
//       color: Colors.cyan[300],
//       completed: true),

//   new Task(
//       name: "Krishna",
//       category: "Medium",
//       time: "20",
//       color: Colors.cyan[100],
//       completed: true),
//    new Task(
//       name: "Yunyi",
//       category: "Beginner",
//       time: "5",//point
//       color: Colors.cyan[50],
//       completed: true),
  
//   new Task(
//       name: "B",
//       category: "Idel",
//       time: "0",
//       color: Colors.cyan[50],
//       completed: true),
// ];

 

class _LeaderPageState extends State<LeaderPage> {
  final double _imageHeight = 256.0;
  String username; 
  String token; 
  List<Player> players;

  @override
  void initState(){
    super.initState();
    print("Leaderboard Screen Initializing");
    _fetchData(); 
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: new Text("Leaderboard"),
      leading: new GestureDetector(
        key: Key("backFromLeaderboard"),
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
      body: players == null ? SpinKitWave(color: Colors.blue[400], duration: new Duration(milliseconds: 1500),) :
      
      new Stack(
        children: <Widget>[
          _buildTimeline(),
          _buildImage(),
          // _buildTopHeader(),
          _buildProfileRow(),
          _buildBottomPart(),
        ],
      ),
    );
  }


  _fetchData() async {
    
    token = await getMobileToken();
    username = await getUsername(); 
    
    print("fetching players data");
    final response = await get("https://fakerinos.herokuapp.com/api/leaderboard/relative/month/",
    headers: {HttpHeaders.authorizationHeader: "Token $token"});

    if (response.statusCode == 200){
      var decodedJson = jsonDecode(response.body);
      print(response.body);
      Players.fromJson(decodedJson);

      setState(() {
        players = Players.players;
            });
      
    }
  }

  

  Widget _buildImage() {
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
          // new Icon(Icons.menu, size: 28.0, color: Colors.white),
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: new Text(
                "Leader oard",
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
                  username,
                  style: new TextStyle(
                      fontSize: 26.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
                new Text(
                  'Level: Wielder of Truth',
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
          players == null? CircularProgressIndicator():
          _buildTasksList()
        ],
      ),
    );
  }

  Widget _buildTasksList() {
    return new Expanded(
      child: new ListView(
        children: players.map((player) => new PlayerRow(player: player, username:username)).toList(),
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
          // new Text(
          //   'Your point:1000',
          //   style: new TextStyle(color: Colors.grey, fontSize: 12.0),
          // ),
          // new Text(
          //   'Your rank:1',
          //   style: new TextStyle(color: Colors.grey, fontSize: 12.0),
          // ),
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
