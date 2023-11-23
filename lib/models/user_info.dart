class UserInfo {
  String? id;
  String? civilite;
  String nom;
  String prenom;
  String? specialite;
  List<String> matieres;

  UserInfo({
    this.id,
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

  factory UserInfo.fromMap(Map<String, dynamic> map) {
    var matieres = map['matieres'];

    if (matieres is List) {
      return UserInfo(
        id: map['id'].toString(),
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
  }
  @override
  String toString() {
    return 'UserInfo{id: $id, civilite: $civilite, nom: $nom, prenom: $prenom, specialite: $specialite, matieres: $matieres}';
  }
}

