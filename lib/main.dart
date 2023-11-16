import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String nom = '';
  String prenom = '';
  String? civilite;
  String? specialite;
  List<String> matieres = [];
  final List<String> specialiteOptions = ['DSI', 'MDW', 'IOT'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulaire Flutter'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0), // Increased padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch the widgets
          children: [
            _buildCiviliteField(),
            _buildTextField('Nom', (value) => nom = value),
            _buildTextField('Prénom', (value) => prenom = value),
            _buildDropdownField('Spécialité', specialite, specialiteOptions,
                    (value) {
                  setState(() {
                    specialite = value;
                  });
                }),
            _buildMatieresField(),
            const SizedBox(height: 20.0), // Space before the button
            ElevatedButton(
              onPressed: _showInfo,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0), // More padding
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: const Text('Afficher'),
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
          child: Text('Civilité', style: Theme.of(context).textTheme.titleLarge),
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
            const Text('Mr.'),
            Radio<String>(
              value: 'Mme.',
              groupValue: civilite,
              onChanged: (value) {
                setState(() {
                  civilite = value;
                });
              },
            ),
            const Text('Mme.'),
            Radio<String>(
              value: 'Mlle.',
              groupValue: civilite,
              onChanged: (value) {
                setState(() {
                  civilite = value;
                });
              },
            ),
            const Text('Mlle.'),
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
          child: Text(label, style: Theme.of(context).textTheme.titleLarge),
        ),
        DropdownButton<String>(
          value: value,
          hint: Text('Choisir $label'),
          onChanged: onChanged,
          items: options
              .map<DropdownMenuItem<String>>(
                  (value) => DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              ))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildTextField(String label, ValueChanged<String> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(label, style: Theme.of(context).textTheme.titleLarge),
        ),
        TextField(
          onChanged: onChanged,
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0), // Rounded corners
            ),
            contentPadding: const EdgeInsets.all(15.0), // Padding inside
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
          child: Text('Matieres', style: Theme.of(context).textTheme.titleLarge),
        ),
        ...['Java', 'Algo', 'Android', 'Python'].map((value) {
          return CheckboxListTile(
            title: Text(value),
            value: matieres.contains(value),
            onChanged: (checked) {
              setState(() {
                if (checked == true) {
                  matieres.add(value);
                } else {
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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InfoPage(
          civilite: civilite,
          nom: nom,
          prenom: prenom,
          specialite: specialite,
          matieres: matieres,
        ),
      ),
    );
  }
}

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
