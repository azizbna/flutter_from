// main.dart
import 'package:flutter/material.dart';
import 'package:formproj/screens/info_page.dart';
import 'package:formproj/screens/user_list.dart';
import 'models/user_info.dart';

void main() {
  runApp(const MyApp());
}

List<UserInfo> users = [];

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulaire',
      theme: ThemeData(
        primarySwatch: Colors.blue, // Changed primary color
        buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0), // Rounded buttons
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final UserInfo? user;
  final Function(UserInfo) onEdit;

  MyHomePage({Key? key, this.user, Function(UserInfo)? onEdit})
      : onEdit = onEdit ?? _defaultOnEdit,
        super(key: key);

  static void _defaultOnEdit(UserInfo editedUser) {}

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String nom = '';
  String prenom = '';
  String? civilite='';
  String? specialite;
  List<String> matieres = [];
  final List<String> specialiteOptions = ['DSI', 'MDW', 'IOT'];
  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  @override
  void initState() {
    super.initState();

    if (widget.user != null) {
      // Load user info if in editing mode
      nomController.text = widget.user!.nom;
      prenomController.text = widget.user!.prenom;
      civilite = widget.user!.civilite ?? '';
      specialite = widget.user!.specialite ?? null; // Initialize specialite if not null

      // Initialize matieres checkboxes based on user's selections
      for (String matiere in ['Java', 'Algo', 'Android', 'Python']) {
        if (widget.user!.matieres.contains(matiere)) {
          matieres.add(matiere);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulaire Flutter'),
        actions: [
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserListPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0), // Increased padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch the widgets
          children: [
            _buildCiviliteField(),
            _buildTextField('Nom', (value) => nom = value, nomController),
            _buildTextField(
                'Prénom', (value) => prenom = value, prenomController),
            _buildDropdownField('Spécialité', specialite, specialiteOptions,
                    (value) {
                  setState(() {
                    specialite = value;
                  });
                }),
            _buildMatieresField(),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                if (widget.user != null) {
                  // Editing mode: update the user
                  UserInfo editedUser = UserInfo(
                    civilite: civilite,
                    nom: nom,
                    prenom: prenom,
                    specialite: specialite,
                    matieres: List.from(matieres),
                  );
                  widget.onEdit(editedUser); // Pass the edited user to the onEdit function
                } else {
                  // Creating a new user: save the user
                  _saveUser();
                }
                _clearForm();
              },
              child: const Text('Enregistrer'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 20.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
            ), // Space before the button
            ElevatedButton(
              onPressed: _showInfo,
              child: const Text('Afficher'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 20.0), // More padding
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCiviliteField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child:
          Text('Civilité', style: Theme
              .of(context)
              .textTheme
              .titleLarge),
        ),
        Row(
          children: [
            Radio<String>(
              value: 'Mr.',
              groupValue: civilite,
              onChanged: (value) {
                setState(() {
                  civilite = value;
                });
              },
            ),
            Text('Mr.'),
            Radio<String>(
              value: 'Mme.',
              groupValue: civilite,
              onChanged: (value) {
                setState(() {
                  civilite = value;
                });
              },
            ),
            Text('Mme.'),
            Radio<String>(
              value: 'Mlle.',
              groupValue: civilite,
              onChanged: (value) {
                setState(() {
                  civilite = value;
                });
              },
            ),
            Text('Mlle.'),
          ],
        ),
      ],
    );
  }

  Widget _buildDropdownField(String label, String? value, List<String> options,
      ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(label, style: Theme
              .of(context)
              .textTheme
              .titleLarge),
        ),
        DropdownButton<String>(
          value: value,
          hint: Text('Choisir $label'),
          onChanged: onChanged,
          items: options
              .map<DropdownMenuItem<String>>(
                  (value) =>
                  DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildTextField(String label,
      ValueChanged<String> onChanged,
      TextEditingController controller, // Add this parameter
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(label, style: Theme
              .of(context)
              .textTheme
              .titleLarge),
        ),
        TextField(
          controller: controller, // Assign the controller here
          onChanged: onChanged,
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            contentPadding: EdgeInsets.all(15.0),
          ),
        ),
      ],
    );
  }

  Widget _buildMatieresField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child:
          Text('Matieres', style: Theme
              .of(context)
              .textTheme
              .titleLarge),
        ),
        ...['Java', 'Algo', 'Android', 'Python'].map((value) {
          bool isSelected = matieres.contains(value);
          return CheckboxListTile(
            title: Text(value),
            value: isSelected,
            onChanged: (checked) {
              setState(() {
                if (checked == true && !matieres.contains(value)) {
                  matieres.add(value);
                } else if (checked == false && matieres.contains(value)) {
                  matieres.remove(value);
                }
              });
            },
          );
        }).toList(),
      ],
    );
  }

  void _showInfo() {
    UserInfo user = new UserInfo(
        civilite: civilite,
        nom: nom,
        prenom: prenom,
        specialite: specialite,
        matieres: matieres);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserInfoPage(user: user),
      ),
    );
  }

  void _saveUser() {
    UserInfo editedUser = UserInfo(
      civilite: civilite,
      nom: nom,
      prenom: prenom,
      specialite: specialite,
      matieres: List.from(matieres),
    );
    print(users);
    setState(() {
      users.add(editedUser); // Add the edited user to the list
    });
  }

  void _clearForm() {
    Future.delayed(const Duration(milliseconds: 150), () {
      setState(() {
        civilite = null;
        specialite = null;
      });
      matieres.clear();
      nomController.clear();
      prenomController.clear();
    });
  }
}
