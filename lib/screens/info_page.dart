// info_page.dart

import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  final String? civilite;
  final String nom;
  final String prenom;
  final String? specialite;
  final List<String> matieres;

  const InfoPage({super.key, 
    required this.civilite,
    required this.nom,
    required this.prenom,
    required this.specialite,
    required this.matieres,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Information'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Civilité: ${civilite ?? "Pas selectionné"}'),
            Text('Nom: $nom'),
            Text('Prénom: $prenom'),
            Text('Spécialité: ${specialite ?? "Pas selectionné"}'),
            Text('Matieres: ${matieres.join(', ')}'),
          ],
        ),
      ),
    );
  }
}
