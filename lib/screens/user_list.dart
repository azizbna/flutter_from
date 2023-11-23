// user_list_page.dart

import 'package:flutter/material.dart';
import '../main.dart';
import '../models/api_helper.dart';
import '../models/user_info.dart';
import 'info_page.dart';

class UserListPage extends StatefulWidget {
  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  List<UserInfo> users = [];
  ApiHelper apiHelper = ApiHelper();

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  void _loadUsers() async {
    try {
      final List<UserInfo> response = await apiHelper.getAllUsers();

      setState(() {
        this.users = response;
      });
    } catch (e) {
      print('Failed to load users: $e');
    }
  }

  void _deleteUser(int index) async {
    if (index >= 0 && index < users.length) {
      final userToDelete = users[index];
      print(userToDelete.toString());
      setState(() {
        users.removeAt(index);
      });

      if (userToDelete.id != null) {
        try {
          await apiHelper.deleteUser(userToDelete.id);
        } catch (e) {
          print('Failed to delete user: $e');
        }
      }
    }
  }

  void _editUser(UserInfo user) {
    if (user.id != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(
            user: user,
            onEdit: (editedUser) async {
              try {
                int index = users.indexWhere((u) => u.id == user.id);
                if (index != -1) {
                  setState(() {
                    users[index] = editedUser;
                  });
                }
                await apiHelper.updateUser(editedUser,user.id);
              } catch (e) {
                print('Failed to edit user: $e');
              }
              Navigator.pop(context); // Close the form
            },
          ),
        ),
      );
    } else {
      // Handle the case where user.id is null
      print('User ID is null');
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

            onPressed: () {},
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
