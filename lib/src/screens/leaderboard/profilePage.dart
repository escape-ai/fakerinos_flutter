import 'package:flutter/material.dart';
import '../sharedPreferencesHelper.dart';
import 'package:http/http.dart';
import 'dart:io';
import 'dart:convert';
import '../user.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import './player.dart';
import './leaderboardPage.dart';
import './player_row.dart';

class ProfilePageState extends StatefulWidget {
  createState(){
    return ProfilePage(); 
  }
}

class ProfilePage extends State<ProfilePageState> {
  String _name = " ";
  String _level = " ";
  // final String _bio = "\"Combat Fakenews!!!\"";
  String _points = " ";
  String _singlemode = " ";
  String _dualmode = " ";
  List<String> _tags=[" "," "," "];
  String _rank="1";
  String firstName = "Loading..."; 
  String lastName = "Loading..."; 
  String username; 
  String token;
  User user;
  Player players;
  List interests = ["Economics", "Social", "Finance"];
  int rank;
  String title; 
  int score; 
  int skillRating; 
  
  @override
  void initState(){
    // fetchProfileData();
    getFullName();
    fetchLeaderboardData();
    // fetchSharedData(); 
    super.initState();
  }

  

  void fetchLeaderboardData() async{
    token = await getMobileToken();
    username = await getUsername();
    print("fetching leaderboard data");
    final response = await get("https://fakerinos.herokuapp.com/api/leaderboard/relative/month/",
    headers: {HttpHeaders.authorizationHeader: "Token $token"});
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200){
      var decodedJson = jsonDecode(response.body);
      print(response.body);
      Players.fromJson(decodedJson);

      for (Player p in Players.players){
        if (p.username == username){
          setState(() {

            print("Found $username");
            rank = p.rank;
            title = parseScoreToTitle(p.score);
            score = p.score;
            skillRating = p.skillRating;
                      
                    });
        }
      }

      
      
    }


  }

  void fetchProfileData() async{
    print("fetching profile data");
    username = await getUsername();
    token = await getMobileToken();
    final profileData = await get("https://fakerinos.herokuapp.com/api/accounts/profile/$username/",
    headers: {HttpHeaders.authorizationHeader: "Token $token"});
    final parsedResponse = json.decode(profileData.body); 

    print(parsedResponse);
    user = User.fromJson(parsedResponse);
    setState(() {
      
        });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          title: Text("Profile Page")
        ),
      // body: user == null? CircularProgressIndicator() : 
      body: rank == null ? SpinKitWave(color: Colors.blue[400], duration: new Duration(milliseconds: 1000),) 
      : Stack(
        children: <Widget>[
          _buildCoverImage(screenSize),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: screenSize.height / 15),
                  _buildProfileImage(),
                  _buildFullName(firstName + lastName),
                  Text(title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  // _buildStatus(context),
                   SizedBox(height: 3.0),
                  _buildRankTag(rank),
                   SizedBox(height: 5.0),
                  _buildStatContainer(),
                  // _buildBio(context),
                  // _buildSeparator(screenSize),
                   SizedBox(height: 10.0),
                  _buildInterestRow(),
                  // _buildSeparator(screenSize),
                  SizedBox(height: 10.0),
                 
                 
                  
              
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCoverImage(Size screenSize) {
    return Container(
      height: screenSize.height / 4.5,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter, 
          end: Alignment.bottomCenter,
          stops: [0.25, 0.75],
          colors: [Color(0xAA03B2FF), Color(0xAA0518FF) ]
        )),);

    // return Container(
    //   height: screenSize.height / 2.6,
    //   decoration: BoxDecoration(
    //     image: DecorationImage(
    //       image: AssetImage('assets/background.jpg'),//
    //       fit: BoxFit.cover,
    //     ),
    //   ),
    // );
  }

  Widget _buildProfileImage() {
    return Tooltip(
      message: "You are good look, believe it!",
      child: Center(
      child: Container(
        width: 140.0,
        height: 140.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/avatar.jpg'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(80.0),
          border: Border.all(
            color: Colors.black,
            width: 3.0,
          ),
        ),
      ),
    ));
  }

  Widget _buildInterestRow(){
    List tags = ["Technology", "Economics", "Politics"];
    return new Padding(
      padding: EdgeInsets.only(top: 7,  bottom: 3),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
      children: tags.map((tag) => new Center(child: _buildInterestTag(tag))).toList()
    ));
  }
  Widget _buildInterestTag(String interestTag){
      
        return new Padding(
          padding: EdgeInsets.only(left: 3, right: 3),
          child: Container(
        
        width: interestTag.length.toDouble() * 10 + 4,
        height: 30,
        child: Center(
          child: Text(interestTag)),
        decoration: BoxDecoration(
          color: Colors.grey[400],
          borderRadius: BorderRadius.circular(50.0),
          // border: Border.all(
          //   color: Colors.black,
          //   width: 1.0,
          // ),
        ),
      ));
    
  }

  Widget _buildRankTag(int rank){
      
        return new Padding(
          padding: EdgeInsets.only(left: 3, right: 3),
          child: Container(
        
        width: 100,
        height: 30,
        child: Center(
          child: Text("Rank: $rank",
          style: TextStyle(

            fontWeight: FontWeight.bold
            
          ),)),
        decoration: BoxDecoration(
          color: Colors.yellow[600],
          borderRadius: BorderRadius.circular(50.0),
          // border: Border.all(
          //   color: Colors.black,
          //   width: 1.0,
          // ),
        ),
      ));
    
  }

  void getFullName() async{
    firstName = await getFirstName(); 
    lastName = await getLastName();
    setState(() {
          

        });
  }

  Widget _buildFullName(String fullname) {
    getFullName(); 
    TextStyle _nameTextStyle = TextStyle(
      color: Colors.black,
      fontSize: 30.0,
      fontWeight: FontWeight.w700,
    );

    return Padding(
      padding: EdgeInsets.only(top: 6),
      child: Text(
      firstName + " " + lastName,
      style: _nameTextStyle,
    ));
  }

  Widget _buildStatus(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        _level,
        style: TextStyle(
          
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String count) {
    TextStyle _statLabelTextStyle = TextStyle(
   
      color: Colors.black,
      fontSize: 16.0,
      fontWeight: FontWeight.w200,
    );

    TextStyle _statCountTextStyle = TextStyle(
      color: Colors.black54,
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          count,
          style: _statCountTextStyle,
        ),
        Text(
          label,
          style: _statLabelTextStyle,
        ),
      ],
    );
  }

  Widget _buildStatContainer() {
    return Container(
      height: 60.0,
      margin: EdgeInsets.only(top: 8.0),
      decoration: BoxDecoration(
        color: Color(0xFFEFF4F7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildStatItem("Total Points", score.toString()),
          _buildStatItem("Skill Rating", skillRating.toString()),
          _buildStatItem("Gamse Played", "16"),
        ],
      ),
    );
  }

  Widget _buildBio(BuildContext context) {
    TextStyle bioTextStyle = TextStyle(

      fontWeight: FontWeight.w400,//try changing weight to w500 if not thin
      fontStyle: FontStyle.italic,
      color: Color(0xFF799497),
      fontSize: 16.0,
    );

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.all(8.0),
      child: Text(
        "placeholder",
        textAlign: TextAlign.center,
        style: bioTextStyle,
      ),
    );
  }

  Widget _buildSeparator(Size screenSize) {
    return Container(
      width: screenSize.width / 1.6,
      height: 2.0,
      color: Colors.black54,
      margin: EdgeInsets.only(top: 4.0),
    );
  }
  
}