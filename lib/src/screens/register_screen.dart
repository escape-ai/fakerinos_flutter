import 'package:flutter/material.dart';
import 'package:http/http.dart' show post;
import '../mixins/validation_mixin.dart';

class RegisterScreen extends StatefulWidget {
  createState() {
    return RegisterScreenState();
  }
}

class RegisterScreenState extends State<RegisterScreen> with ValidationMixin {
  final formKey = GlobalKey<FormState>();
  final String url = "https://fakerinos.herokuapp.com/api/accounts/register/";
  String email = '';
  String username = '';
  String password1 = '';
  String password2 = '';

  Widget build(context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Form(
        key: formKey,
        child: Column(children: [
          Container(margin: EdgeInsets.only(top: 120.0)),
          usernameField(),
          emailField(),
          passwordField(),
          confirmPasswordField(),
          Container(margin: EdgeInsets.only(top: 120.0)),
          submitButton()
        ]),
      ),
    );
  }

  Widget usernameField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Username',
        hintText: 'Sudiptarocks',
      ),
      validator: (String value) {
        if (value.length < 5) {
          return 'Please enter a username longer than 5 characters';
        }
      },
      onSaved: (String value) {
        username = value;
        print(value);
      },
    );
  }

  Widget emailField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email Address',
        hintText: 'fakerinos@gmail.com',
      ),
      validator: validateEmail,
      onSaved: (String value) {
        email = value;
        print(value);
      },
    );
  }

  Widget passwordField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Enter your password',
      ),
      validator: validatePassword,
      onSaved: (String value) {
        password1 = value;
        print(value);
      },
    );
  }

  Widget confirmPasswordField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Confirm Password',
        hintText: 'Enter your password',
      ),
      validator: validatePassword,
      onSaved: (String value) {
        password2 = value;
        print(value);
      },
    );
  }

  Widget submitButton() {
    return RaisedButton(
        child: Text("Submit"),
        color: Colors.blueGrey,
        onPressed: () {
          if (formKey.currentState.validate()) {
            // print(formKey.currentState);
            formKey.currentState.save();
            // print('time to post $email and $email to my api');
            Register();
          }
        });
  }

  void Register() async {
    print("Registering with server side...");
    Map<String, String> payload = {
      "username": username,
      "email": email,
      "password1": password1,
      "password2": password2
    };
    final response = await post(url, body: payload);

    print(response.body);
  }
}
