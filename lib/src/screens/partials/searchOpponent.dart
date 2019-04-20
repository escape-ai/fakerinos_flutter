import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SearchOpponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
   backgroundColor: Colors.cyan[400],
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.cyan[400],
        title: Text("Dual Mode", style: TextStyle(fontSize: 24.0)),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 48.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              
                SpinKitRipple(color: Colors.white,size:200.0,
                duration: Duration(milliseconds: 3000)),
              ],
            ),
            const SizedBox(height: 48.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Searching for another player...", style: TextStyle(fontSize: 24.0),textAlign: TextAlign.center,),
              
              ],
            ),
            const SizedBox(height: 60.0),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                 Text("Click the upper-left cross to stop searching.", style: TextStyle(fontSize: 16.0),textAlign: TextAlign.center,),
                
              ],
            ),
            const SizedBox(height: 48.0),


          ],
        ),
      ),
    );
  }
}