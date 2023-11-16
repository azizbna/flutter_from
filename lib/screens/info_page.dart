// user_info_page.dart

import 'package:flutter/material.dart';
import '../models/user_info.dart';

class UserInfoPage extends StatelessWidget {
  final UserInfo? user;

  UserInfoPage({required this.user});

  Future<void> _showUserInfoModal(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('User Information'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoText('Civilité', user?.civilite),
                _buildInfoText('Nom', user?.nom),
                _buildInfoText('Prénom', user?.prenom),
                _buildInfoText('Spécialité', user?.specialite),
                _buildInfoText(
                  'Matieres',
                  user?.matieres.join(', '), // Join matieres into a string
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInfoText(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: RichText(
        text: TextSpan(
          style: TextStyle(color: Colors.black),
          children: [
            TextSpan(
              text: '$label: ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: value ?? 'Not available'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Utilisateur'),
      ),
      body: user != null
          ? buildUserInfo(context, user!)
          : Center(
        child: Text('User information not found.'),
      ),
    );
  }

  Widget buildUserInfo(BuildContext context, UserInfo userInfo) {
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
          ElevatedButton(
            onPressed: () {
              _showUserInfoModal(context);
            },
            child: Text('Afficher dans une modal'),
          ),
        ],
      ),
    );
  }
}
