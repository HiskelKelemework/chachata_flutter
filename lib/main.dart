import 'package:flutter/material.dart';
import 'package:telegram_clone/services/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final AuthService _auth = AuthService();

  Widget _buildAuthenticationArea() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            color: Colors.green,
            child: Text('Sign up'),
            onPressed: () async {
              // final dynamic user =
              //     await _auth.createWithPhoneNum('+251911932901');
              final dynamic user =
                  await _auth.createUser('mekedem@gmail.com', 'password');
              print(user);
            },
          ),
          FlatButton(
            color: Colors.blue,
            child: Text('Sign in'),
            onPressed: () async {
              final dynamic user =
                  await _auth.signIn('mekedem@gmail.com', 'password');
              print(user);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHomeArea() {
    return Center(
      child: Column(
        children: <Widget>[
          FlatButton(
            color: Colors.red,
            child: Text('Sign out'),
            onPressed: () async {
              final dynamic user = await _auth.signOut();
              print(user);
            },
          ),
          FlatButton(
            color: Colors.red,
            child: Text('Delete Account'),
            onPressed: () async {
              final dynamic user = await _auth.deleteAccount();
              print(user);
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('Chachata'),
          ),
          body: StreamBuilder(
            stream: _auth.user(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                print(snapshot.data);
                return _buildHomeArea();
              }
              return _buildAuthenticationArea();
            },
          )),
    );
  }
}
