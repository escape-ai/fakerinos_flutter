import './player.dart';
import 'package:flutter/material.dart';
import './leaderboardPage.dart';
import '../sharedPreferencesHelper.dart';

class PlayerRow extends StatefulWidget {
  final Player player;
  final String username;

  final double dotSize = 12.0;
  

  const PlayerRow({Key key, this.player, this.username}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new PlayerRowState();
  }
}


 String parseScoreToTitle(int score){
    
    String rank; 
    if (score < 100) {
      rank = "Fact Noob";
    }

    else if (score < 1000) {
      rank = "The Discerner";
    }

    else if (score < 3000) {
      rank = "Perceptive Pro";
    }

    else if (score < 5000) {
      rank = "Master";
    }


    else if (score < 7000) {
      rank = "Grandmaster";
    }

    else if (score < 10000) {
      rank = "Wielder of Truth";
    }

    else if (score < 400000) {
      rank = "Legendary Factchecker";
    }

    else {
      
      rank = "Probably the Developer";
    }
    
    return rank;

  }

class PlayerRowState extends State<PlayerRow> {
  @override
  Widget build(BuildContext context) {
    getUsername();
    return new Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: new Row(
        children: <Widget>[
          new Padding(
            padding:
                new EdgeInsets.symmetric(horizontal: widget.player.username == widget.username ? 32.0 - widget.dotSize  : 32.0 - widget.dotSize / 2),
            child: new Container(
              height: widget.player.username == widget.username ? widget.dotSize *2 : widget.dotSize,
              width: widget.player.username == widget.username ? widget.dotSize *2 : widget.dotSize,
              decoration: new BoxDecoration(
                  shape: BoxShape.circle, color: widget.player.username == widget.username ? Colors.blue : Colors.black),
            ),
          ),
          new Expanded(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  widget.player.username,
                  style: new TextStyle(fontSize: 18.0),
                ),
                new Tooltip(
                  message: "Skill Rating is a specially calculated score that considers how often you are correct!",
                  child: new Text(
                  "Skill Rating: ${widget.player.skillRating}",
                  style: new TextStyle(fontSize: 12.0, color: Colors.cyan[500]),
                ),
                ),
                
                new Text(
                  "Rank: ${parseScoreToTitle(widget.player.score)}",
                  style: new TextStyle(fontSize: 12.0, color: Colors.deepOrange),
                )
              ],
            ),
          ),
          new Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: new Text(
              widget.player.score.toString(),
              style: new TextStyle(fontSize: 15.0, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }


}
