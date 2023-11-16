// user_info_page.dart

import 'package:flutter/material.dart';
import '../models/user_info.dart';

class UserInfoPage extends StatelessWidget {
  final UserInfo? user;

  UserInfoPage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Utilisateur'),
      ),
      body: user != null
          ? buildUserInfo(user!)
          : Center(
        child: Text('User information not found.'),
      ),
    );
  }

  Widget buildUserInfo(UserInfo userInfo) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              'Civilité',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(userInfo.civilite ?? 'Pas selectionné'),
          ),
          ListTile(
            title: Text(
              'Nom',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(userInfo.nom),
          ),
          ListTile(
            title: Text(
              'Prénom',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(userInfo.prenom ?? 'Pas selectionné'),
          ),
          ListTile(
            title: Text(
              'Spécialité',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(userInfo.specialite ?? 'Pas selectionné'),
          ),
          ListTile(
            title: Text(
              'Matieres',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: userInfo.matieres
                  .map((matiere) => Text('• $matiere'))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

}

