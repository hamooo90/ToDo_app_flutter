import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yaddasht_flutter/models/theuser.dart';
import 'package:yaddasht_flutter/services/database.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<UserNotes>>(
        stream: DatabaseService(uid: 'lReeUewIpaZ008rQ9yFXKt467FA3').notes,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<UserNotes> notesList = snapshot.data;
            print(notesList.length);
            // return Text('yes');
            return ListView.builder(
              itemCount: notesList.length,
              itemBuilder: (context, index) {
                return Text(notesList[index].text);
              },
            );
          } else {
            return Text('no');
          }
        },
      ),
    );
  }
}
