// user_list_page.dart

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

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
  void _saveUsersAsJSON() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/users.json');
      final jsonUsers = users.map((user) => user.toJson()).toList();
      await file.writeAsString(jsonEncode(jsonUsers));

      // Display a toast message with the location
      final location = file.path;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Users saved to: $location'),
        duration: Duration(seconds: 3),
      ));
    } catch (e) {
      // Handle any potential errors
      print('Error while saving users: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to save users'),
        duration: Duration(seconds: 3),
      ));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Utilisateurs'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveUsersAsJSON();
            },
          ),
        ],
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
              title: Text(
                '${user.civilite} ${user.nom} ${user.prenom}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Spécialité: ${user.specialite}',
                style: TextStyle(
                  color: Colors.grey, // Secondary color for specialty
                ),
              ),
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
