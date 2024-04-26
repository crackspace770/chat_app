
import 'package:chat_app/page/chat_page.dart';
import 'package:chat_app/service/auth_service.dart';
import 'package:chat_app/service/chat_service.dart';
import 'package:chat_app/widget/my_drawer.dart';
import 'package:flutter/material.dart';

import '../widget/user_tile.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  //chat & auth service
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(
        title:  Text("ChatApp",
        style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      drawer: const MyDrawer(),
      body: _buildUserList(),
    );
  }

  //build list of user except the one who currently logged in
  Widget _buildUserList() {
    return StreamBuilder(
        stream: _chatService.getUserStream(),
        builder: (context, snapshot) {

          //error
          if(snapshot.hasError) {
            return const Text("Error");
          }

          //loading
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          //return listview
          return ListView(
            children: snapshot.data!.map<Widget>((userData) => _buildUserListItem(userData,context))
                .toList(),
          );
        }
        );
  }

  //build individual list tile of user
  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    //display all user
    return UserTile(
      text: userData['username'],
      onTap: () {
        //go to chat page
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
              receiverEmail: userData['username'],
                receiverID: userData['uid'],
              ),
           ),
        );
      },

    );
  }

}
