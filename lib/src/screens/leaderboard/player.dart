import 'package:flutter/material.dart';

class Players {
  static List <Player> players; 

  Players.fromJson(List<dynamic> playersJson){

    players = new List<Player>();
    playersJson.forEach((player) => {
      players.add(new Player.fromJson(player))
    });
  }
}

class Player {
  int rank; 
  int score; 
  int skillRating; 
  String username; 

  Player(this.rank, this.score, this.skillRating, this.username); 

  Player.fromJson(dynamic playerJson){
    rank = playerJson["rank"];
    score = playerJson["score"];
    skillRating = playerJson["skillRating"];
    username = playerJson["username"];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> output = new Map<String, dynamic>();
    output["rank"] = this.rank;
    output["score"] = this.score; 
    output["skillRating"] = this.skillRating; 
    output["username"] = this.username; 

    return output; 
  }


}


// [
//     {
//         "rank": 1,
//         "username": "tasercake",
//         "score": 0,
//         "skill_rating": 500
//     },
//     {
//         "rank": 2,
//         "username": "lionell26",
//         "score": 0,
//         "skill_rating": 500
//     }
// ]