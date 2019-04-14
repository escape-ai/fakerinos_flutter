class ValidationMixin {
  String validateEmail(String value) {
    if (!value.contains('@')) {
      return 'Please enter a valid email!';
    }

    return null;
  }

  String validatePassword(String value) {
    if (value.length < 4) {
      return 'Please enter a longer password!';
    }

    return null;
  }

  String validateFirstName(String value){
    if (value.length < 3) {
      return 'First name needs to be at least 3 characters long'; 
    } 
  }

  String validateLastName(String value){
    if (value.length < 3) {
      return 'First name needs to be at least 3 characters long'; 
    } 
   
  }

  String validateUsername(String username){
    if (username.length < 6){
      return "Usernames must be at least 6 characters long";
    }
  }
}
