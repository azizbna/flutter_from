// user_list_page.dart

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../main.dart';
import '../models/database_helper.dart';
import '../models/user_info.dart';
import 'info_page.dart';
class UserListPage extends StatefulWidget {
  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  List<UserInfo> users = [];

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  void _loadUsers() async {
    final users = await DatabaseHelper.instance.queryAllUsers();
    setState(() {
      this.users = users.map((user) {
        return UserInfo(
          id: user.id,
          civilite: user.civilite ?? '', // Handle null values
          nom: user.nom,
          prenom: user.prenom,
          specialite: user.specialite ?? '', // Handle null values
          matieres: user.matieres,
        );
      }).toList();
    });
  }
  void _deleteUser(int index) async {
    if (index >= 0 && index < users.length) {
      final userToDelete = users[index];
      print(userToDelete.toString());
      setState(() {
        users.removeAt(index);
      });

      if (userToDelete.id != null) {
        await DatabaseHelper.instance.delete(userToDelete.id!);
      }
    }
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
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
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