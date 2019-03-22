import "package:flutter/material.dart"; 

class MultiplayerScreen extends StatefulWidget{
  @override
  createState(){
    return MultiplayerScreenState(); 
  }
}

class MultiplayerScreenState extends State<MultiplayerScreen>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Text("Sorry the multiplayer page is under construction!",
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold
      ),
      textAlign: TextAlign.center,)
    );  
  }

  
}

