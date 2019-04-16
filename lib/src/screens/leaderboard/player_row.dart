import './player.dart';
import 'package:flutter/material.dart';

class PlayerRow extends StatefulWidget {
  final Player player;
  final double dotSize = 12.0;

  const PlayerRow({Key key, this.player}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new PlayerRowState();
  }
}

class PlayerRowState extends State<PlayerRow> {
  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: new Row(
        children: <Widget>[
          new Padding(
            padding:
                new EdgeInsets.symmetric(horizontal: 32.0 - widget.dotSize / 2),
            child: new Container(
              height: widget.dotSize,
              width: widget.dotSize,
              decoration: new BoxDecoration(
                  shape: BoxShape.circle, color: Colors.black),
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
                new Text(
                  "placeholder",
                  style: new TextStyle(fontSize: 12.0, color: Colors.grey),
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
