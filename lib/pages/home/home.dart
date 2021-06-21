
import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:yaddasht_flutter/models/theuser.dart';
import 'package:yaddasht_flutter/pages/home/add_edit.dart';
import 'package:yaddasht_flutter/pages/home/search.dart';
import 'package:yaddasht_flutter/pages/home/test.dart';
import 'package:yaddasht_flutter/services/auth.dart';
import 'package:yaddasht_flutter/services/database.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:yaddasht_flutter/shared/color.dart';
import 'package:yaddasht_flutter/shared/style.dart';

import '';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  AuthService _auth =AuthService();
  UserNotes empty = UserNotes(text: '',title: '',docId: '',colorIndex: 0,time: '');
  // UserNotes empty = UserNotes(text: '',title: '',docId: '');


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<TheUser>(context);
    // return SafeArea(
    //   child: Scaffold(
    //     backgroundColor: Colors.blueGrey,
    //     appBar: FloatAppBar(),
    //     body: RaisedButton(
    //       onPressed:()async{ await _auth.signOut();} ,
    //     ),
    //   ),
    // );
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Hexcolor('#202123')
    ));

    return SafeArea(
      child: Scaffold(
        extendBody: true,
        backgroundColor: Hexcolor('#202123'),
        body: StreamBuilder(
            stream: DatabaseService(uid: user.uid).notes,
            builder: (context,snapshot){
              
              if(!snapshot.hasData){
                return CustomScrollView(
                  slivers: <Widget>[

                    appBarCustom(context, user, _auth),

                  ],
                );
              }
              else{
                List<UserNotes> notesList = snapshot.data;
                print(snapshot.data.length);
                return CustomScrollView(
                  slivers: <Widget>[

                    appBarCustom(context, user, _auth),
                    listCustom(user, notesList),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (context, index) => SizedBox(height: 50,),
                        childCount: 1,
                      ),
                    ),

                  ],
                );
              }

            }
        ),
        drawer: Drawer(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,

        floatingActionButton: fabOpenAnimation(AddEditPage(note: empty,)),

        bottomNavigationBar: BottomAppBar(
            color: Hexcolor('#2f3032').withOpacity(0.95),
            shape: CircularNotchedRectangle(),
            child: Container(
              height: 50,

            )
        ),
      ),
    );


  }
}



Widget fabOpenAnimation(Widget widget){
  return OpenContainer(
    // transitionDuration: Duration(milliseconds: 500),
    // transitionType: ContainerTransitionType.fadeThrough,
    closedShape: CircleBorder(),
    openColor: Colors.grey[900],
    closedColor: Colors.grey[900],
    closedBuilder: (context,openWidget){
      return FloatingActionButton(
        backgroundColor: Hexcolor('#2f3032'),
        heroTag: "btn1",
        child: Icon(Icons.add),
        onPressed: openWidget,
      );
    },
    openBuilder: (context,closeWidget){
      return widget;
    },
  );
}
// Widget searchOpenAnimation(){
//   return OpenContainer(
//     // transitionDuration: Duration(milliseconds: 500),
//     // transitionType: ContainerTransitionType.fadeThrough,
//     // closedShape: CircleBorder(),
//     // transitionType: ContainerTransitionType.fade,
//     // openColor: Colors.grey[900],
//     // closedShape: CircleBorder(),
//     closedColor: Hexcolor('#313335'),
//     closedBuilder: (context,openWidget){
//       return Container(
//         height: 70, width: MediaQuery.of(context).size.width,
//         child: Center(
//           child: Text(
//               'Search',
//               style: TextStyle(color: Colors.white70),
//             ),
//         ),
//       );
//     },
//     openBuilder: (context,closeWidget){
//       return Search();
//     },
//   );
// }

appBarCustom(context , user,AuthService _auth){
  return SliverPadding(
    padding: EdgeInsets.fromLTRB(20,20,20,10),
    sliver: SliverAppBar(
      // leading: FlatButton.icon(onPressed: (){}, icon: Icon(Icons.email), label: Text('')),
      leadingWidth: 60,
      actions: [
        Padding(
            padding: EdgeInsets.all(10),
            child: FloatingActionButton(
              elevation: 0,
              child: Text(user.email[0].toUpperCase()),
              onPressed: (){
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: Colors.grey[800],
                    elevation: 0,
                    content: Container(
                      width: 100,height: 80,
                      child: Column(
                        children: [
                          Text(
                            user.email,
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 10,),
                          FlatButton(
                              color: Colors.yellow[900],
                              onPressed: () async{
                                await _auth.signOut();
                                Navigator.pop(context);
                              },
                              child: Text('Sign out')
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
        )
      ],
      // title: searchOpenAnimation(),
      title: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Search()),
        );
      },
      child: SizedBox(

        height: 70,width: MediaQuery.of(context).size.width,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Search',
            style: TextStyle(color: Colors.white70),
             // textAlign: TextAlign.center,
          ),
        ),
      ),
    ),
      // title: TextFormField(
      //   onTap: (){
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => Search()),
      //     );
      //   },
      //   decoration: textInputDecoration.copyWith(hintText: 'Search'),
      //   style: TextStyle(
      //       color: Colors.white,
      //   ),
      // ),
      backgroundColor: Hexcolor('#313335'),
      snap: true,
      // pinned: true,
      floating: true,
      shape:ContinuousRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20)
        ),
      ),
    ),
  );
}

listCustom(user,notesList){
  return SliverList(
    delegate: SliverChildBuilderDelegate(
          (context, index) => Container(
          margin: EdgeInsets.only(right: 8,left: 8),
          child: Dismissible(
            onDismissed: (direction) async{
              final snackBar = SnackBar(
                  content: Text('Note Deleted!'),
                  // duration: ,
                  // action: SnackBarAction(
                  //   label: 'Undo',
                  //   onPressed: (){},
                  // ),
              );
              Scaffold.of(context).showSnackBar(snackBar);
              return DatabaseService(uid: user.uid).deleteNote(notesList[index].docId);
            },
            key: UniqueKey(),
            child: GestureDetector(
              onTap: () async{
                print(index);
                print(notesList[index].docId);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddEditPage(note: notesList[index],)),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white54, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                // color: Colors.red,
                color: colorPallet[notesList[index].colorIndex],
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
              ),
            ),
          )
      ),
      childCount: notesList.length,
    ),
  );
}