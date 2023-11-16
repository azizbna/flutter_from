import 'dart:convert';

import 'database_helper.dart';

class UserInfo {
  int? id; // Add this 'id' field
  String? civilite;
  String nom;
  String prenom;
  String? specialite;
  List<String> matieres;

  UserInfo({
    this.id, // Include 'id' in the constructor
    this.civilite,
    required this.nom,
    required this.prenom,
    this.specialite,
    required this.matieres,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'civilite': civilite,
      'nom': nom,
      'prenom': prenom,
      'specialite': specialite,
      'matieres': matieres.join(', '), // Use join with a comma and space
    };
  }

  // Create a method to create a UserInfo object from a map
  factory UserInfo.fromMap(Map<String, dynamic> map) {
    var matieres = (map['matieres'] as String).split(', ');
    return UserInfo(
      id: map['id'], // Include 'id' in the factory constructor
      civilite: map['civilite'],
      nom: map['nom'],
      prenom: map['prenom'],
      specialite: map['specialite'],
      matieres: matieres,
    );
  }
  @override
  String toString() {
    return 'UserInfo{id: $id, civilite: $civilite, nom: $nom, prenom: $prenom, specialite: $specialite, matieres: $matieres}';
  }
}

