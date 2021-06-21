import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yaddasht_flutter/models/theuser.dart';

class DatabaseService {
  final String uid;
  // final String email;


  DatabaseService({this.uid});

  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('Users');
  final FirebaseFirestore notesCollection = FirebaseFirestore.instance;

  Future addUpdateUserData(String name, String email) async {
    return await usersCollection.doc(uid).set({
      'uid' : uid,
      'name' : name,
      'email' : email,
    });
  }
  Future addNote(String title,String text,int color,String time) async{
    return await notesCollection.collection(uid).add(
      {
        'title' : title,
        'text' : text,
        'color' : color,
        'time' :time
      }
    );
  }
  Future updateNote(String title,String text,String docId,int color,String time) async{
    return await notesCollection.collection(uid).doc(docId).update(
      {
        'title' : title,
        'text' : text,
        'color' : color,
        'time' :time
      }
    );
  }

  // Future addNote(String title,String text,int color) async{
  //   return await notesCollection.collection(uid).add(
  //       {
  //         'title' : title,
  //         'text' : text,
  //         'color' : color
  //       }
  //   );
  // }
  // Future updateNote(String title,String text,String docId,int color) async{
  //   return await notesCollection.collection(uid).doc(docId).update(
  //       {
  //         'title' : title,
  //         'text' : text,
  //         'color' : color
  //       }
  //   );
  // }

  Future deleteNote(String docId) async{
    return await notesCollection.collection(uid).doc(docId).delete();
  }

  List<UserNotes> _notesListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      return UserNotes(
          title: doc.get('title') ?? '',
          text: doc.get('text') ?? '',
          docId: doc.id ,
          colorIndex: doc.get('color'),
          time: doc.get('time')
      );
    }).toList();
  }

  Stream<List<UserNotes>> get notes {
    return notesCollection.collection(uid).snapshots()
        .map(_notesListFromSnapshot);
  }


  // List<UserNotes> _notesListFromSnapshot(QuerySnapshot snapshot) {
  //   return snapshot.docs.map((doc){
  //     return UserNotes(
  //       title: doc.get('title') ?? '',
  //       text: doc.get('text') ?? '',
  //       docId: doc.id ,
  //       colorIndex: doc.get('color')
  //     );
  //   }).toList();
  // }
  //
  // Stream<List<UserNotes>> get notes {
  //   return notesCollection.collection(uid).snapshots()
  //     .map(_notesListFromSnapshot);
  // }



}