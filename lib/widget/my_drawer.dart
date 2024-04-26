import 'package:chat_app/page/setting_page.dart';
import 'package:flutter/material.dart';

import '../service/auth_service.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout(){
    final _auth = AuthService();
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              //logo
              const DrawerHeader(
                  child: Center(
                      child: Icon(
                          Icons.message,
                          size: 40,
                      )
                  )
              ),

              //home list tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: const Text("H O M E"),
                  leading: const Icon(Icons.home),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),

              //setting list
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: const Text("S E T T I N G"),
                  leading: const Icon(Icons.settings),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingPage(), )
                    );
                  },
                ),
              ),
            ],
          ),

          //Logout
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 25.0),
            child: ListTile(
              title: const Text("L O G O U T"),
              leading: const Icon(Icons.logout),
              onTap: logout,
            ),
          ),

        ],
      ),
    );
  }
}
