
class TheUser {
  final String uid;
  final String email;
  // final String name;
  static String userId;


  TheUser({this.uid,this.email}){
    userId=uid;
  }
}

class UserNotes {
  final String title;
  final String text;
  final String docId;

  final String time;
  final int colorIndex;

  UserNotes({this.title, this.text, this.docId, this.colorIndex,this.time});
  // UserNotes({this.title, this.text, this.docId, this.colorIndex});

  bool isNotNull(){
    if(title=='' && text=='' && docId==''){
      return true;
    } else{
      return false;
    }
  }


}