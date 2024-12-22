import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/profile_service.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String birthDate = '';
  String address = '';
  String postalCode = '';
  String city = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    final profileData = await ProfileService.getUserProfile();
    if (profileData != null) {
      setState(() {
        email = FirebaseAuth.instance.currentUser?.email ?? '';
        password = profileData['password'] ?? '';
        birthDate = profileData['birthDate'] ?? '';
        address = profileData['address'] ?? '';
        postalCode = profileData['postalCode'] ?? '';
        city = profileData['city'] ?? '';
        isLoading = false;
      });
    } else {
      print('No profile data available.');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    await ProfileService.updateUserProfile({
      'password': password,
      'birthDate': birthDate,
      'address': address,
      'postalCode': postalCode,
      'city': city,
    });

    await ProfileService.updateUserPassword(password);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profil mis à jour avec succès')),
    );
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Top Bar
                Container(
                  color: Colors.teal,
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  width: double.infinity,
                  child: const Center(
                    child: Text(
                      'Mon profil',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Email (Read-only)
                          TextFormField(
                            initialValue: email,
                            readOnly: true,
                            decoration: const InputDecoration(
                              labelText: 'Login',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Password (Hidden)
                          TextFormField(
                            initialValue: password,
                            obscureText: true,
                            onChanged: (value) => password = value,
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Birth Date with Format Validation
                          TextFormField(
                            initialValue: birthDate,
                            onChanged: (value) => birthDate = value,
                            validator: (value) {
                              if (value == null || !RegExp(r'^\d{2}/\d{2}/\d{4}$').hasMatch(value)) {
                                return 'Veuillez entrer une date valide (JJ/MM/AAAA)';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: 'Anniversaire (JJ/MM/AAAA)',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Address
                          TextFormField(
                            initialValue: address,
                            onChanged: (value) => address = value,
                            decoration: const InputDecoration(
                              labelText: 'Adresse',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Postal Code
                          TextFormField(
                            initialValue: postalCode,
                            keyboardType: TextInputType.number,
                            onChanged: (value) => postalCode = value,
                            decoration: const InputDecoration(
                              labelText: 'Code Postal',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 10),

                          // City
                          TextFormField(
                            initialValue: city,
                            onChanged: (value) => city = value,
                            decoration: const InputDecoration(
                              labelText: 'Ville',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Validate Button
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,
                              padding: const EdgeInsets.symmetric(horizontal: 50),
                            ),
                            onPressed: _saveProfile,
                            child: const Text('Valider'),
                          ),
                          const SizedBox(height: 10),

                          // Logout Button
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              padding: const EdgeInsets.symmetric(horizontal: 50),
                            ),
                            onPressed: _logout,
                            child: const Text('Se déconnecter'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
