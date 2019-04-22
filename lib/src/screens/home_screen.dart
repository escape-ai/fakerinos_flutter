import 'package:flutter/material.dart'; 

import './partials/default.dart'; 
import './partials/multiplayer_screen.dart';
import './partials/crowdSource.dart';
import "../screens/leaderboard/profilePage.dart";
import '../SwipeAnimation/index.dart';
import '../screens/leaderboard/leaderboardPage.dart';
import '../../src/screens/sharedPreferencesHelper.dart';

class HomeScreen extends StatefulWidget{
  createState() {
      
      return HomeStateScreen();
    }
}

class HomeStateScreen extends State<HomeScreen> {
  int _currentIndex = 0; 
  int _selectedDrawerIndex = -1;
  String initials = "";
  String username = "Default"; 
  String email = "Default"; 
  String name = "Default";


  void initState() {
  
   loadDataFromSharedPreferences();

   super.initState();
}
  void loadDataFromSharedPreferences() async {
  
  String firstName = await getFirstName();
  String lastName = await getLastName();
  username = await getUsername(); 
  
  name = firstName + " " + lastName; 
  email = firstName + lastName + "@gmail.com";

  setState((){
    initials = firstName[0].toUpperCase() + lastName[0].toUpperCase();
  });
  
}
  

  _getDrawerItemWidget(int pos){
    switch(pos) {
      case 0:
        print("0");
        break; 
      case 1: 
        print("1"); 
        break; 
      case 2:
        print("2"); 
        break;
      case 3: 
        print("3"); 
        break; 

      default:
        return new Text("Error"); 
    }
  }

  

  _onSelectItem(int index){
    setState(() {
          _selectedDrawerIndex = index; 
        });
    Navigator.of(context).pop(); 
  }

  final List<Widget> _children = [
    DefaultHomeScreen(),  
    MultiplayerScreen(), 
    CrowdSourceScreen()
  ]; 

  void onTabTapped(int index){
    setState((){
      _currentIndex = index; 
    });
  }
  List<StatefulWidget> screens = [HomeScreen(), MultiplayerScreen()];
  @override
  Widget build(context){
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Home Page")
        ),
        body: _children[_currentIndex], 
    
      drawer: buildDrawerWidget(context, name, initials, username, email),
      
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, 
        currentIndex: _currentIndex,
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
            
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.play_arrow),
            title: Text("Multiplayer"),
            
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.people),
            title: Text("Crowd Source")
          ),
          
        ],
        
      ),
      )
    );
} } 


// https://medium.com/@kashifmin/flutter-setting-up-a-navigation-drawer-with-multiple-fragments-widgets-1914fda3c8a8
  Widget buildDrawerWidget(BuildContext context, String name, String initials, String username, String email) {
  

    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
        children: <Widget>[
          Container( 
            child: UserAccountsDrawerHeader(
            accountName: new Text(name),
            accountEmail: new Text(email),
            currentAccountPicture: new CircleAvatar(
              backgroundColor: Colors.black, 
              child: Text(initials,
              textScaleFactor: 2,)
            ),
          )),
          new ListTile(
            key: Key("viewPersonalProfile"),
            title: new Text("Personal Profile"),
            trailing: new Icon(Icons.person),
            onTap: ()=> {
            print("push is to be implemented"),
            Navigator.push(context,
            new MaterialPageRoute(builder: (context)=> ProfilePageState()))
            }
          ),
          new ListTile(
            title: new Text("Settings"),
            trailing: new Icon(Icons.settings),
          ), 
          new ListTile(
            title: new Text("About"),
            trailing: new Icon(Icons.question_answer),
          ),
          new ListTile(
            title: new Text("Feedback"),
            trailing: new Icon(Icons.feedback),
          )
          ],
      ))
    );


}
