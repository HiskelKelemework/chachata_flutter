import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telegram_clone/screens/message/message.dart';
import 'package:telegram_clone/services/auth.dart';

class ChatScreen extends StatelessWidget {
  Widget _buildCustomListTile(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (ctx) => MessagesPage()));
      },
      onLongPress: () {},
      child: Container(
        margin: const EdgeInsets.only(bottom: 2),
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              radius: 30,
            ),
            Expanded(
              child: Container(
                height: 70,
                padding: const EdgeInsets.only(left: 15, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Here is the title',
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      'Here is the subtitle ere is the subtitle ere is the subtitle ere is the subtitle',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                    Divider(
                      thickness: 1.5,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Container(),
              ),
              FlatButton(
                color: Colors.red,
                child: Text('Sign out'),
                onPressed: () async {
                  final auth = Provider.of<AuthService>(context, listen: false);
                  Navigator.of(context).pop(); // don't delete!
                  final dynamic user = await auth.signOut();
                  print(user);
                },
              ),
              FlatButton(
                color: Colors.red,
                child: Text('Delete Account'),
                onPressed: () async {
                  final auth = Provider.of<AuthService>(context, listen: false);
                  final dynamic user = await auth.deleteAccount();
                  print(user);
                },
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text('Messages'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 15.0,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (ctx, index) {
                return _buildCustomListTile(context, index);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
