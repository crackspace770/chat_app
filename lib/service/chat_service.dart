import 'package:chat_app/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService{

  //get instance of firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //get user stream
Stream<List<Map<String, dynamic>>> getUserStream() {
  return _firestore.collection("user").snapshots().map((snapshot) {
    return snapshot.docs.map((doc)  {
      //go through each individual user
      final user = doc.data();

      //return user
      return user;
    }).toList();
  });
  
  }

  Future<void> sendMessage(String receiverID, message) async{

  //get current user info
  final String currentUserID = _auth.currentUser!.uid;
  final String currentUserEmail = _auth.currentUser!.email!;
  final Timestamp timestamp = Timestamp.now();

  //create new message
  Message newMessage = Message(
      senderID: currentUserID,
      senderEmail: currentUserEmail,
      receiverID: receiverID,
      message: message,
      timestamp: timestamp
  );

  //construct chat room ID for 2 users {sorted to ensure uniqueness}
  List<String> ids = [currentUserID, receiverID];
  ids.sort(); //sort the ids (this ensure the chatroomID is the same for 2 user)
  String chatRoomID  = ids.join('_');

  //add messages to database
  await _firestore
      .collection('chat_rooms')
      .doc(chatRoomID)
      .collection('messages')
      .add(newMessage.toMap());
  }

  //get messages
  Stream<QuerySnapshot> getMessages(String userID, otherUserID) {
  //construct chat room id for 2 users
    List<String>ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');
    
    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
    
  }

}