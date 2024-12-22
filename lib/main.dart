import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart'; // Import de l'écran principal
import 'themes/app_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Monsif Harchaoui APP',
      theme: AppTheme.lightTheme,
      home: AuthenticationWrapper(), // Utiliser un wrapper pour gérer l'état de connexion
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(), // Vérifie l'état de connexion
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator()); // Affiche un loader en attendant
        }
        if (snapshot.hasData) {
          return HomeScreen(); // L'utilisateur est connecté, redirige vers HomeScreen
        }
        return LoginScreen(); // Sinon, affiche la page de connexion
      },
    );
  }
}
