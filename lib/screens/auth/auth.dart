import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telegram_clone/services/auth.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String _email = '';
  String _password = '';
  bool _onSignIn = true;

  Widget _buildSignUpScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
            onChanged: (email) => _email = email,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                hintText: 'Email', border: OutlineInputBorder())),
        SizedBox(height: 10.0),
        TextField(
            onChanged: (password) => _password = password,
            obscureText: true,
            decoration: InputDecoration(
                hintText: 'Password', border: OutlineInputBorder())),
        FlatButton(
          color: Colors.green,
          child: Text('Sign Up'),
          onPressed: () async {
            final auth = Provider.of<AuthService>(context, listen: false);
            final dynamic user = await auth.createUser(_email, _password);
            print(user);
          },
        ),
        FlatButton(
          color: Colors.green,
          child: Text('Sign In instead'),
          onPressed: () {
            setState(() {
              _onSignIn = true;
            });
          },
        ),
      ],
    );
  }

  Widget _buildSignInScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          onChanged: (email) => _email = email,
          keyboardType: TextInputType.emailAddress,
          decoration:
              InputDecoration(hintText: 'Email', border: OutlineInputBorder()),
        ),
        SizedBox(
          height: 10.0,
        ),
        TextField(
            onChanged: (password) => _password = password,
            obscureText: true,
            decoration: InputDecoration(
                hintText: 'Password', border: OutlineInputBorder())),
        FlatButton(
          color: Colors.green,
          child: Text('Sign In'),
          onPressed: () async {
            final auth = Provider.of<AuthService>(context, listen: false);
            final dynamic user = await auth.signIn(_email, _password);
            print(user);
          },
        ),
        FlatButton(
          color: Colors.green,
          child: Text('Sign Up instead'),
          onPressed: () {
            setState(() {
              _onSignIn = false;
            });
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _onSignIn ? _buildSignInScreen() : _buildSignUpScreen());
  }
}
