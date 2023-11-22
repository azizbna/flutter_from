import 'dart:convert';

import 'database_helper.dart';

class UserInfo {
<<<<<<< Updated upstream
  int? id; // Add this 'id' field
=======
  String? id; // Add this 'id' field
>>>>>>> Stashed changes
  String? civilite;
  String nom;
  String prenom;
  String? specialite;
  List<String> matieres;

  UserInfo({
<<<<<<< Updated upstream
    this.id, // Include 'id' in the constructor
=======
    this.id,
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
    var matieres = (map['matieres'] as String).split(', ');
    return UserInfo(
      id: map['id'], // Include 'id' in the factory constructor
      civilite: map['civilite'],
      nom: map['nom'],
      prenom: map['prenom'],
      specialite: map['specialite'],
      matieres: matieres,
    );
=======
    var matieres = map['matieres'];

    if (matieres is List) {
      // 'matieres' is already a List
      return UserInfo(
        id: map['id'].toString(), // Ensure id is converted to String
        civilite: map['civilite'],
        nom: map['nom'],
        prenom: map['prenom'],
        specialite: map['specialite'],
        matieres: matieres.cast<String>(),
      );
    } else if (matieres is String) {
      // 'matieres' is a comma-separated String
      return UserInfo(
        id: map['id'].toString(), // Ensure id is converted to String
        civilite: map['civilite'],
        nom: map['nom'],
        prenom: map['prenom'],
        specialite: map['specialite'],
        matieres: matieres.split(',').map((e) => e.trim()).toList(),
      );
    } else {
      throw Exception("Invalid 'matieres' format");
    }
>>>>>>> Stashed changes
  }
  @override
  String toString() {
    return 'UserInfo{id: $id, civilite: $civilite, nom: $nom, prenom: $prenom, specialite: $specialite, matieres: $matieres}';
  }
}

