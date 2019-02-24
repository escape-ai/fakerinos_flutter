import 'package:flutter/material.dart'; 

class HomeScreen extends StatefulWidget{
  createState() {
      
      return HomeStateScreen();
    }
}

class HomeStateScreen extends State<HomeScreen> {
  int _currentIndex = 0; 
  final List<Widget> _children = []; 

  void onTabTapped(int index){
    setState((){
      _currentIndex = index; 
    });
  }
  @override
  Widget build(context){
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Home Page")
        ),
      body: Text("Welcome"),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              padding:EdgeInsets.zero,
              child: Text('Fakerinos'),
              decoration: BoxDecoration(
                color: Colors.blue,
              )
            ),
            ListTile(
              title: Text('Profile'),
              onTap:(){

              })
          ]
        )
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home")
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.people),
            title: Text("Multiplayer")
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