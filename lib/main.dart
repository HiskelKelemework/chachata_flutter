import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telegram_clone/models/user.dart';
import 'package:telegram_clone/screens/auth/auth.dart';
import 'package:telegram_clone/screens/chats/chat.dart';
import 'package:telegram_clone/services/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    return MultiProvider(
      providers: [
        Provider<AuthService>.value(value: _auth),
        StreamProvider<User>.value(value: _auth.user),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Wrapper(),
      ),
    );
  }
}

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<User>(
        builder: (_, user, __) {
          if (user != null) {
            return ChatScreen();
          }
          return AuthScreen();
        },
      ),
    );
  }
}
