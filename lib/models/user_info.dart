class UserInfo {
  String? civilite;
  String nom;
  String prenom;
  String? specialite;
  List<String> matieres;

  UserInfo({
    this.civilite,
    required this.nom,
    required this.prenom,
    this.specialite,
    required this.matieres,
  });

  // Factory constructor to create a UserInfo object from a JSON map
  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      civilite: json['civilite'],
      nom: json['nom'],
      prenom: json['prenom'],
      specialite: json['specialite'],
      matieres: List<String>.from(json['matieres']),
    );
  }

  // Method to convert UserInfo object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'civilite': civilite,
      'nom': nom,
      'prenom': prenom,
      'specialite': specialite,
      'matieres': matieres,
    };
  }
}
