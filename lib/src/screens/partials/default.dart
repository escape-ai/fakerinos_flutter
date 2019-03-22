import "package:flutter/material.dart"; 
import "../../SwipeAnimation/index.dart";

class DefaultHomeScreen extends StatefulWidget{
  @override
  createState(){
    return DefaultHomeStateScreen(); 
  }
}

class DefaultHomeStateScreen extends State<DefaultHomeScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        itemBuilder: (BuildContext context, int index) {
          if(index <= 2 ) {
            return _buildCarousel(context, index ~/ 2);
          }
          else {
            return Divider(
              height: 3
            );
          }
        },
      ), );
  }

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


}

