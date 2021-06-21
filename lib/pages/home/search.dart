import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:yaddasht_flutter/models/theuser.dart';
import 'package:yaddasht_flutter/pages/home/home.dart';
import 'package:yaddasht_flutter/services/database.dart';
import 'package:yaddasht_flutter/shared/style.dart';

String txtSearch = '';


class SearchWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    // String aaa=TheUser.userId;
    // print(TheUser.userId);
    return Scaffold(
      backgroundColor: Hexcolor('#202123'),
      appBar: AppBar(
        
        toolbarHeight: 70,
        backgroundColor: Colors.grey[800],
        title: TextFormField(
          autofocus: true,
          decoration: textInputDecoration.copyWith(hintText: 'Search'),
          onChanged: (val){
            setState(() {
              txtSearch=val;
            });
          },
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      // body: ListView.builder(
      //   itemCount: asd.length,
      //   itemBuilder: (context, index) {
      //     return ListTile(
      //       title: Text(asd[index].text),
      //     );
      //   },
      // ),
      body: StreamBuilder(
        stream: DatabaseService(uid: TheUser.userId).notes,
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            return Center(child: Text('No Data!',style: TextStyle(color: Colors.white),));
          } else {
            List<UserNotes> notesList = snapshot.data;
            // asd=notesList;
            // notesList2
            return ListView.builder(
              itemCount: notesList.length,
              itemBuilder: (context, index) {
                if (notesList[index].text.contains(txtSearch)) {
                  return ListTile(
                    title: Text(notesList[index].text,style: TextStyle(color: Colors.white),),
                  );
                } else {
                  return SizedBox();
                  // return ListTile(
                  //   title: Text(notesList[index].text),
                  // );
                }
              },
            );
          }
          // print(snapshot.data.length);
              // listCCustom('lReeUewIpaZ008rQ9yFXKt467FA3', notesList),
              // return null;
                  // delegate: SliverChildBuilderDelegate(
                  //     (context,index) {
                  //       if(notesList[index].text.contains(txtSearch)){
                  //         return Text(notesList[index].text);
                  //       }
                  //       else {
                  //         return null;
                  //       }
                  //
                  //     },
                  //   childCount: notesList.length
                  // )
              // );


        },
      ),
    );
  }
}

List<UserNotes> filterSearch(String val){
  List<UserNotes> notesList;
  List<UserNotes> filteredList;
  StreamBuilder(
      stream: DatabaseService(uid: TheUser.userId).notes,
      builder: (context, snapshot) {
        notesList = snapshot.data;
        return null;
      }
  );
  for(int i=0;i<notesList.length;i++){
    if(notesList[i].text.contains(val)){
      filteredList.add(notesList[i]);
    }
  }
  return filteredList;

}


listCCustom(user,notesList){

  return SliverList(
    delegate: SliverChildBuilderDelegate(
          (context, index) {
            if(notesList[index].text.contains(txtSearch))
              {
            return Container(
                margin: EdgeInsets.only(right: 8,left: 8),
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white54, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          notesList[index].title,
                          style: TextStyle(color: Colors.white,),
                        ),
                        Text(
                          notesList[index].text,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                )
            );
              }else {
              return null;
            }

          },
      childCount: notesList.length,
    ),
  );
}