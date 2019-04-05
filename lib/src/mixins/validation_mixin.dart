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
      // return null;
    }

    return null;
  }

  String validateFirstName(String value){
    if (value.length < 1) {
      return 'First Name cannot be empty'; 
    } 

    return null; 
  }
}
