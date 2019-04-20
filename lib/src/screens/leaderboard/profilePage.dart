import 'package:flutter/material.dart';
import '../sharedPreferencesHelper.dart';

class ProfilePageState extends StatefulWidget {
  createState(){
    return ProfilePage(); 
  }
}

class ProfilePage extends State<ProfilePageState> {
  final String _name = "Lionell Loh";
  final String _level = "Master Player";
  final String _bio = "\"Combat Fakenews!!!\"";
  final String _points = "1000";
  final String _singlemode = "24";
  final String _dualmode = "450";
  final List<String> _tags=["Politics","Education","Economics"];
  final String _rank="1";
  String firstName; 
  String lastName; 
  
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildCoverImage(screenSize),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: screenSize.height / 6.4),
                  _buildProfileImage(),
                  _buildFullName("Lionell"),
                  _buildStatus(context),
                  _buildRankTag(3),
                  _buildStatContainer(),
                  // _buildBio(context),
                  // _buildSeparator(screenSize),
                  _buildInterestRow(_tags),
                  // _buildSeparator(screenSize),
                  SizedBox(height: 10.0),
                  _buildNewsInterest(context),
                  SizedBox(height: 10.0),
                  _buildRank(context),
              
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
      height: screenSize.height / 3.5,
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
    return Center(
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
    );
  }

  Widget _buildInterestRow(List<String> tags){
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
      fontSize: 20.0,
      fontWeight: FontWeight.w700,
    );

    return Text(
      firstName + " " + lastName,
      style: _nameTextStyle,
    );
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
          _buildStatItem("Points", _points),
          _buildStatItem("Single Mode", _singlemode),
          _buildStatItem("Dual Mode", _dualmode),
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
        _bio,
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

  Widget _buildNewsInterest(BuildContext context) {
    String _interest=_tags.join(",");
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.only(top: 8.0),
      child: Text(
        "I am insterested in News under these categories: ${_interest}",
        style: TextStyle(fontFamily: 'Roboto', fontSize: 16.0),
      ),
    );
  }
  Widget _buildRank(BuildContext context) {
    String _interest=_tags.join(",");
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.only(top: 8.0),
      child: Text(
        "I am ranked: ${_rank} in the world",
        style: TextStyle( fontSize: 16.0),
      ),
    );
  }
  
}