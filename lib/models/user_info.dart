List<UserInfo> userList = [];

class UserInfo {
  final String? civilite;
  final String nom;
  final String prenom;
  final String? specialite;
  final List<String> matieres;

  UserInfo({
    this.civilite,
    required this.nom,
    required this.prenom,
    this.specialite,
    required this.matieres,
  });
}
