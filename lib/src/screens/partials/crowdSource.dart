import "package:flutter/material.dart"; 

class CrowdSourceScreen extends StatefulWidget{
  @override
  createState(){
    return CrowdSourceScreenState(); 
  }
}

class CrowdSourceScreenState extends State<CrowdSourceScreen>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Text("Sorry the crowd source screen page is under construction!",
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold
      ),
      textAlign: TextAlign.center,)
    );  
  }

  
}

