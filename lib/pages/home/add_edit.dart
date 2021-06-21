
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:yaddasht_flutter/models/theuser.dart';
import 'package:yaddasht_flutter/services/auth.dart';
import 'package:yaddasht_flutter/services/database.dart';
import 'package:yaddasht_flutter/shared/color.dart';
import 'package:yaddasht_flutter/shared/style.dart';


int btmSht=0;
int bgColorIndex=0;
// Color bgColor = colorPallet[0];

class AddEditPage extends StatelessWidget {
   final UserNotes note;
   AddEditPage({this.note});

  @override
  Widget build(BuildContext context) {
    print(note.text);
    return StreamProvider<TheUser>.value(
        value: AuthService().user,
        child: AddEditWrapper(note: note,)
    );
  }
}

class AddEditWrapper extends StatefulWidget {
  final UserNotes note;
  AddEditWrapper({this.note});

  bool isEdit(){
    if(note.title!='' && note.text!='' && note.docId!=''){
      return true;
    }else{
      return false;
    }
  }

  @override
  _AddEditWrapperState createState() => _AddEditWrapperState();
}

class _AddEditWrapperState extends State<AddEditWrapper> {
  String title="",text="";//,time;
  var time;
  String result;
  int hh=50;



  @override
  void initState() {
    // TODO: implement initState
    if(widget.isEdit()){
      // print(widget.note.title);
      title = widget.note.title;
      text = widget.note.text;
      bgColorIndex=widget.note.colorIndex;
      time = DateTime.parse(widget.note.time);
      print('yess');
    }
    else{
      bgColorIndex = 0;
      time=DateTime.now();
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<TheUser>(context);


    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Hexcolor('#292923')
    ));

    return WillPopScope(
      onWillPop: () {
        print('back pressed');
        // if(title.isNotEmpty && text.isNotEmpty) {
        var currTime = DateTime.now();


        if(widget.isEdit()){
          if(title!=widget.note.title || text!=widget.note.text || bgColorIndex!=widget.note.colorIndex ){
            dynamic result = updateNote(user, title, text, widget.note.docId, bgColorIndex,currTime.toString());
          }
        } else {
          dynamic result = addNote(user, title, text, bgColorIndex,currTime.toString());
        }

        // if(widget.isEdit()){
        //   dynamic result = updateNote(user, title, text, widget.note.docId, bgColorIndex);
        // } else {
        //   dynamic result = addNote(user, title, text, bgColorIndex);
        // }

        // }
        // if(title.isEmpty){
        //   print('empty');
        // }
        btmSht=0;
        print(result.toString());
        // if(result == null){
        //   Scaffold.of(context).showSnackBar(SnackBar(content: Text('Empty Yaddasht discarded')));
        // }
        Navigator.of(context).pop();
        // Navigator.pop(context,text);
        return Future.value(false);
      },
      child: Scaffold(
        // backgroundColor: Hexcolor('#202123'),
        backgroundColor: colorPallet[bgColorIndex],
        appBar: AppBar(
          // leading: IconButton(
          //   icon: Icon(Icons.arrow_back),
          //   onPressed: (){},
          //
          // ),
          // backgroundColor: Hexcolor('#202123'),
          backgroundColor: colorPallet[bgColorIndex],
          elevation: 0,
        ),
        body: GestureDetector(
          onTap: (){
            setState(() {
              // btmSht=0;
            });
          },
          child: Column(
            children: [

              Expanded(
                child: ListView(
                  padding: EdgeInsets.only(left: 10,right: 10,top: 10),
                  children: [
                    TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: 'Title'),
                      initialValue: title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),
                      onChanged: (val){
                        setState(() {
                          title=val;
                        });
                      },
                      onTap: (){
                        setState(() {
                          btmSht=0;
                        });
                      },
                    ),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: 'Note'),
                      initialValue: text,
                      style: TextStyle(
                          color: Colors.white,
                      ),
                      autofocus: true,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      minLines: 10,
                      onChanged: (val){
                        setState(() {
                          text=val;
                        });
                      },
                      onTap: (){
                        setState(() {
                          btmSht=0;
                        });
                      },
                    ),

                    // RaisedButton(
                    //   child: Text('btn'),
                    //   onPressed: (){
                    //     setState(() {
                    //       if(bgColorIndex==10){
                    //         bgColorIndex=0;
                    //       }else{
                    //         bgColorIndex++;
                    //       }
                    //     });
                    //   },
                    // )


                    // RaisedButton(
                    //   child: Text('text'),
                    //   onPressed: () async{
                    //     addNote(user, title, text);
                    //     // dynamic result = await DatabaseService(uid: user.uid).addD(title,text);
                    //     // print('**clicked**');
                    //     // print(result.toString());
                    //     FocusScope.of(context).unfocus();
                    //     Navigator.of(context).pop();
                    //     // setState(() {
                    //     //   result = _db.toString();
                    //     // });
                    //     //     '12', 'hamed', 3
                    //   // );
                    //
                    // }),
                    // RaisedButton(
                    //     onPressed: () async {
                    //       Navigator.of(context).push(MaterialPageRoute(builder: (context) => Test()));
                    //       CollectionReference _db = FirebaseFirestore.instance.collection(user.uid);
                    //       // print(_db.doc().parent);
                    //       _db.get().then((snapshot) {
                    //         snapshot.docs.forEach((result) {
                    //           print(result.data());
                    //           // print(result.get('title'));
                    //
                    //         });
                    //       });
                    //     },
                    //     child: Text('result'),
                    // ),


                    // StreamProvider<List<UserNotes>>.value(
                    //   value: DatabaseService().notes,
                    //   child: Text('test 1234',style: TextStyle(color: Colors.white)),
                    //
                    // )

                    // StreamBuilder(
                    //   stream: FirebaseFirestore.instance.collection(user.uid).snapshots(),
                    //   builder: (context, snapshot){
                    //     return (!snapshot.hasData)
                    //         ? Center(child: Text('hello',style: TextStyle(color: Colors.white),),)
                    //         : ListView.builder(
                    //           // itemCount: snapshot.data.docs.length,
                    //           itemBuilder: (context, index){
                    //             DocumentSnapshot data = snapshot.data.docs[index];
                    //             return Text(data.get('title'));
                    //           }
                    //         );
                    //   }
                    // )
                  ],
                ),
              ),


              BottomAppBar(
                // color: Hexcolor('#2f3032').withOpacity(0.95),
                color: colorPallet[bgColorIndex],
                child: Container(
                  // height: 150,
                  child: Column(
                    children: [
                      GestureDetector(
                        // onVerticalDragStart: (det){
                        //   print(det);
                        // },
                        onVerticalDragEnd: (det){
                          print(det);
                          if(det.primaryVelocity>0){
                            setState(() {
                              btmSht=0;
                            });
                          }
                        },

                        // child: BottomSheetC()
                          ////////////////////BottomSheet/////////////////////////
                        child: Builder(
                          builder: (BuildContext context) {
                            if(btmSht == 1){
                              return Container(
                                  child: SizedBox(
                                    height: 150,
                                    child: ListView(
                                      children: [
                                        Container(
                                          height: 30,
                                          // color: Hexcolor('#2f3032'),
                                          // color: colorPallet[bgColorIndex],
                                          alignment: Alignment.topCenter,
                                          child: SizedBox.expand(
                                            child: FlatButton.icon(
                                              onPressed: (){
                                                setState(() {
                                                  btmSht=0;
                                                });
                                              },
                                              icon: Icon(Icons.arrow_drop_down,color: Colors.white,),
                                              label: Text(''),
                                            ),
                                          ),
                                          // child: IconButton(color: Colors.blue,
                                          //     icon: Icon(Icons.arrow_drop_down,color: Colors.white,),
                                          //     onPressed: (){
                                          //       setState(() {
                                          //         btmSht=0;
                                          //       });
                                          //       // print('heyyyyy');
                                          //     }
                                          // )
                                        ),
                                        Container(height: 50),
                                        SizedBox(
                                          height: 50,
                                          child: ListView.builder(
                                            itemCount: colorPallet.length,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (BuildContext context, int index){
                                              return Container(
                                                margin: EdgeInsets.symmetric(vertical: 8,horizontal: 5),
                                                child: GestureDetector(
                                                  onTap: (){
                                                    print('chicked $index');
                                                    setState(() {
                                                      // bgColor = colorPallet[index];
                                                      bgColorIndex=index;
                                                    });
                                                    // print(bgColor);
                                                  },
                                                  child: CircleAvatar(
                                                    backgroundColor: Colors.black,
                                                    radius: 17,
                                                    child: CircleAvatar(
                                                      radius: 16,
                                                      backgroundColor: colorPallet[index],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                              );
                            }
                            else{
                              return Container();
                            }
                            ////////////////////////////BottomSheet////////////////////////////
                          },
                        )

                      ),
                      Row(

                        children: [
                          IconButton(icon: Icon(Icons.add_box_outlined, color: Colors.white), onPressed: null),
                          Expanded(child: Center(child: Text('Edited '+checkTimeDate(time), style: TextStyle(color: Colors.white),))),
                          IconButton(icon: Icon(Icons.more_vert_outlined, color: Colors.white), onPressed: (){
                            FocusScope.of(context).unfocus();
                            if(btmSht==0){setState(() {
                              btmSht=1;
                              });
                            }
                            else if(btmSht==1){setState(() {
                              btmSht=0;
                              });
                            }

                          }),

                        ],
                      ),
                    ],
                  ),
                ),
              )

            ],
          ),
        ),


      ),
    );
  }
}
class ListNotes extends StatefulWidget {
  @override
  _ListNotesState createState() => _ListNotesState();
}

class _ListNotesState extends State<ListNotes> {
  @override
  Widget build(BuildContext context) {

    // final notes = Provider.of<List<UserNotes>>(context) ?? [];
    return Container(
      child: Text('hello',style: TextStyle(color: Colors.white),),
    );
  }
}


class BottomSheetC extends StatefulWidget {
  @override
  _BottomSheetCState createState() => _BottomSheetCState();
}

class _BottomSheetCState extends State<BottomSheetC> {
  @override
  Widget build(BuildContext context) {
    if(btmSht == 1){
      return Container(
          child: SizedBox(
            height: 150,
            child: ListView(
              children: [
                Container(
                    height: 30,
                    color: Hexcolor('#2f3032'),
                    alignment: Alignment.topCenter,
                    child: SizedBox.expand(
                      child: FlatButton.icon(
                        onPressed: (){
                          setState(() {
                            btmSht=0;
                          });
                        },
                        icon: Icon(Icons.arrow_drop_down,color: Colors.white,),
                        label: Text(''),
                      ),
                    ),
                    // child: IconButton(color: Colors.blue,
                    //     icon: Icon(Icons.arrow_drop_down,color: Colors.white,),
                    //     onPressed: (){
                    //       setState(() {
                    //         btmSht=0;
                    //       });
                    //       // print('heyyyyy');
                    //     }
                    // )
                ),
                Container(height: 50,color: Hexcolor('#2f3032')),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    itemCount: colorPallet.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index){
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 8,horizontal: 5),
                        child: GestureDetector(
                          onTap: (){
                            print('chicked $index');
                            setState(() {
                              // bgColor = colorPallet[index];
                              bgColorIndex=index;
                            });
                            // print(bgColor);
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 17,
                            child: CircleAvatar(
                              radius: 16,
                              backgroundColor: colorPallet[index],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          )
      );
    }
    else{
      return Container();
    }
  }
}


dynamic addNote(var user,String title,String text,int color,String time) async{
  if(title.isNotEmpty && text.isNotEmpty) {
    dynamic result = await DatabaseService(uid: user.uid).addNote(title,text,color,time);
    print(result.toString());
    return result;
  } else{
    return null;
  }
}

dynamic updateNote(var user,String title,String text,String docId,int color,String time) async{
  if(title.isNotEmpty && text.isNotEmpty) {
    dynamic result = await DatabaseService(uid: user.uid).updateNote(title,text,docId,color,time);
    print(result.toString());
    return result;
  } else{
    return null;
  }
}

String checkTimeDate(var time){
  var timeNow = DateTime.now();
  var diffTime = timeNow.difference(time);
  int diffDay = diffTime.inDays;
   if(diffDay==0){
    return time.hour.toString()+':'+time.minute.toString();
  // } else if(diffDay==1){
  //   return 'yesterday at '+time.hour.toString()+':'+time.minute.toString();
  } else{
     DateFormat formatter = DateFormat('d MMM');
     String formattttt = formatter.format(time);
    return  formattttt.toString();//time.month.toString()+':'+time.hour.toString()+' '+time.minute.toString();
  }
}

// dynamic addNote(var user,String title,String text,int color) async{
//   if(title.isNotEmpty && text.isNotEmpty) {
//     dynamic result = await DatabaseService(uid: user.uid).addNote(title,text,color);
//     print(result.toString());
//     return result;
//   } else{
//     return null;
//   }
// }
//
// dynamic updateNote(var user,String title,String text,String docId,int color) async{
//   if(title.isNotEmpty && text.isNotEmpty) {
//     dynamic result = await DatabaseService(uid: user.uid).updateNote(title,text,docId,color);
//     print(result.toString());
//     return result;
//   } else{
//     return null;
//   }
// }
