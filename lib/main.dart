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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Chachata'),
        ),
        body: Center(
          child: Text('Welcome to Chachata'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            dynamic result =
                await _auth.createUser('dawitgizaw@gmail.com', 'my pass');
            print(result);
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
