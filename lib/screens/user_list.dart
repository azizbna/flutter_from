// user_list_page.dart

import 'package:flutter/material.dart';

import '../main.dart';
import '../models/user_info.dart';
import 'info_page.dart';
class UserListPage extends StatefulWidget {
  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  void _deleteUser(int index) {
    setState(() {
      users.removeAt(index);
    });
  }

  void _editUser(UserInfo user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyHomePage(
          user: user,
          onEdit: (editedUser) {
            // Update the edited user in the userList
            setState(() {
              int index = users.indexWhere((u) => u == user);
              if (index != -1) {
                users[index] = editedUser;
              }
            });
            Navigator.pop(context); // Close the form
          },
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Utilisateurs'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          Color? cardColor = index % 2 == 0 ? Colors.white : Colors.grey[200];
          UserInfo user = users[index];

          return Card(
            color: cardColor,
            elevation: 4,
            margin: EdgeInsets.all(8),
            child: ListTile(
              title: Text('${user.nom} ${user.prenom}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteUser(index);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      _editUser(user);
                    },
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserInfoPage(user: user),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
