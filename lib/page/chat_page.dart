
import 'package:chat_app/service/auth_service.dart';
import 'package:chat_app/service/chat_service.dart';
import 'package:chat_app/widget/chat_buble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {

  final String receiverEmail;
  final String receiverID;

  ChatPage({super.key,
    required this.receiverEmail,
    required this.receiverID});

  //text controller
  final TextEditingController _messageController = TextEditingController();

  // chat & auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  //send message
  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      //send message
      await _chatService.sendMessage(receiverID, _messageController.text);

      //clear text controller
      _messageController.clear();

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(receiverEmail),
      ),
      body: Column(
        children: [
          //display all messages
          Expanded(child: _buildMessageList(),
          ),

          //user input
          _buildUserInput()

        ],
      ),
    );
  }

  //build message list
  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(receiverID, senderID),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.chat_outlined,
                  size: 40,
                  ),
                  SizedBox(height: 10),
                  Text("No Messages"),
                ],
              ));
        }
        // Return list tile
        return Expanded(
          child: ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return _buildMessageItem(snapshot.data!.docs[index]);
            },
          ),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    //is current user
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;

    //align message to right if sender is current user, otherwise left
    var alignment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    // Return a Text widget with the message
    return Container(
        alignment: alignment,
        child: Column(
          crossAxisAlignment:
          isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start ,
          children: [
           ChatBubble(message: data['message'],
               isCurrentUser: isCurrentUser
           ),
          ],
        ),
    );
  }

  //build message input
  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Row(
        children: [
          //textfiled should take up most of the space
          Expanded(
            child:
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26),
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(16)
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: TextField(
                  controller: _messageController,
                  decoration:  InputDecoration(
                      hintText: "Type a message",
                      hintStyle: TextStyle(
                        color: Colors.black
                      ),
                      border: InputBorder.none,

                  ),

                ),
              ),
            ),
          ),
          ),

          Container(
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle
            ),
            margin: EdgeInsets.only(right: 25),
            child: IconButton(
                onPressed: sendMessage,
                icon: Icon(Icons.send,
                color: Colors.white,
                )
            ),
          ),

        ],
      ),
    );
  }

}
