import 'package:flutter/material.dart'; 
import './multiplayer_screen.dart';
import '../SwipeAnimation/index.dart';

class HomeScreen extends StatefulWidget{
  createState() {
      
      return HomeStateScreen();
    }
}

class HomeStateScreen extends State<HomeScreen> {
  int _currentIndex = 0; 
  final List<Widget> _children = [
    MultiplayerScreen(), 
    HomeScreen(), 
    MultiplayerScreen()
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
      // body: ListView.builder(
      //   padding: EdgeInsets.symmetric(vertical: 16.0),
      //   itemBuilder: (BuildContext context, int index) {
      //     if(index <= 2 ) {
      //       return _buildCarousel(context, index ~/ 2);
      //     }
      //     else {
      //       return Divider(
      //         height: 3
      //       );
      //     }
      //   },
      // ),
      drawer: buildDrawerWidget(context),
      
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

Widget _buildCarousel(BuildContext context, int carouselIndex) {
    final headers = ["Recommended For You", "Trending", "Newest"]; 
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(headers[carouselIndex]),
        SizedBox(
          // you may want to use an aspect ratio here for tablet support
          height: 200.0,
          child: PageView.builder(
            // store this controller in a State to save the carousel scroll position
            controller: PageController(viewportFraction: 0.8),
            itemBuilder: (BuildContext context, int itemIndex) {
              return _buildCarouselItem(context, carouselIndex, itemIndex);
            },
          ),
        )
      ],
    );
  }

  Widget _buildCarouselItem(BuildContext context, int carouselIndex, int itemIndex) {
    return Center(
      child: GestureDetector(
        onTap: ()=> Navigator.push(context,
        new MaterialPageRoute(builder: (context)=> CardDemo())),
        onDoubleTap: ()=> showDialog( 
          context: context,
          builder: (BuildContext context){
          return AlertDialog(
          title: new Text("You liked this"));
          }), 
        child: Card(
        elevation: 10,
        child: Column(
          mainAxisSize: MainAxisSize.max, 
          children: <Widget>[
            const ListTile(
            leading: Icon(Icons.album), 
            title: Text('Lala'), 
            subtitle: Text("Subtitle"))]
            ,)
            ,)
            ,));
  }

  Widget buildDrawerWidget(BuildContext context) {

    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
        children: <Widget>[
          Container( 
            child: UserAccountsDrawerHeader(
            accountName: new Text("Lionell Loh"),
            accountEmail: new Text("lionellloh@gmail.com"),
            currentAccountPicture: new CircleAvatar(
              backgroundColor: Colors.black, 
              child: Text("LL",
              textScaleFactor: 1.5,)
            ),
          )),
          new ListTile(
            title: new Text("Personal Profile"),
            trailing: new Icon(Icons.person)
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
