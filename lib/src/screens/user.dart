class Users {

  List<User> users;

  Users(this.users);

  Users.fromJson(List<dynamic> usersJson){

    users = new List<User>(); 
    usersJson.forEach((user)=> {
      users.add(new User.fromJson(user))
    });
  }
}

class User{

  String username; 
  // List interests;
  String education; 
  bool isComplete;
  bool onboarded;
  int age;
  String gender;
  String birthDate;
  String firstName;
  String lastName;
  dynamic avatar;

  User(
    this.username, 
    // this.interests, 
    this.education, 
    this.onboarded, 
    this.age, 
    this.gender,
    this.birthDate,
    this.firstName,
    this.lastName,
    this.avatar);

  User.fromJson(dynamic userJson){
    username = userJson["user"];
    // interests = userJson["interests"];
    education = userJson["education"];
    isComplete = userJson["is_complete"];
    age = userJson["age"];
    gender = userJson["gender"];
    birthDate = userJson["birth_date"];
    firstName = userJson["first_name"];
    lastName = userJson["last_name"];
    avatar = userJson["avatar"];
    onboarded = userJson["onboarded"];
  }

}


// {
//     "user": "lionell26",
//     "interests": [],
//     "education": "Primary",
//     "is_complete": false,
//     "age": 8,
//     "gender": "Unknown",
//     "birth_date": "2011-01-01",
//     "name": "lion",
//     "avatar": null,
//     "onboarded": false
// }