import 'package:flutter/material.dart';

class MessagesPage extends StatelessWidget {
  Widget _buildAppBarContent(BuildContext context) {
    return Container(
      child: Row(children: <Widget>[
        // IconButton(
        //   icon: Icon(Icons.arrow_back_ios),
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        // ),
        CircleAvatar(),
        Padding(
          padding: const EdgeInsets.only(top: 8, left: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'This works',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                'This also works',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: _buildAppBarContent(context),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {},
            )
          ],
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                reverse: true,
                itemBuilder: (ctx, index) {
                  final max_width = MediaQuery.of(context).size.width - 150;
                  final text_style =
                      TextStyle(fontSize: 15, fontWeight: FontWeight.w500);
                  final alignment = index % 2 == 0
                      ? Alignment.centerLeft
                      : Alignment.centerRight;
                  return Align(
                    alignment: alignment,
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      width: max_width,
                      child: Align(
                        alignment: alignment,
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: index % 2 == 0 ? Colors.blue : Colors.red,
                              borderRadius: BorderRadius.circular(10)),
                          child: index % 2 == 0
                              ? Text(
                                  'This with a really really really really really really really really long content',
                                  style: text_style,
                                )
                              : Text(
                                  'This is small text really',
                                  style: text_style,
                                ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      maxLines: 8,
                      minLines: 1,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25)),
                          hintText: 'Enter message here'),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.only(right: 8),
                      child: Icon(
                        Icons.send,
                        size: 40,
                      ),
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
