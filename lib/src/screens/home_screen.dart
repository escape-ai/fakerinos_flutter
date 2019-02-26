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
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        itemBuilder: (BuildContext context, int index) {
          if(index % 2 == 0) {
            return _buildCarousel(context, index ~/ 2);
          }
          else {
            return Divider();
          }
        },
      ),
      drawer: buildDrawerWidget(context),
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
      ),
    );
  }

  Widget buildDrawerWidget(BuildContext context) {

    return Drawer(
      child: Container(
        color: Colors.blueGrey,
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
