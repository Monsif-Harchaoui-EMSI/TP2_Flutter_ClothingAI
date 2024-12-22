import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/tflite_service.dart';

class AddClothingScreen extends StatefulWidget {
  @override
  _AddClothingScreenState createState() => _AddClothingScreenState();
}

class _AddClothingScreenState extends State<AddClothingScreen> {
  final _formKey = GlobalKey<FormState>();
  String imageUrl = '';
  String title = '';
  String category = 'Inconnu';
  String size = '';
  String brand = '';
  String price = '';
  bool isLoading = false;

  final TFLiteService _tfliteService = TFLiteService();

  Future<void> _fetchCategory() async {
    if (imageUrl.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez entrer un lien d\'image')),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      // Run the TensorFlow Lite model
      final categoryResult = await _tfliteService.classifyImageFromUrl(imageUrl);
      setState(() {
        category = categoryResult ?? 'Inconnu';
      });
    } catch (e) {
      print('Error fetching category: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erreur lors de la classification')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _saveClothing() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      await FirebaseFirestore.instance.collection('clothing').add({
        'imageUrl': imageUrl,
        'title': title,
        'category': category,
        'size': size,
        'brand': brand,
        'price': double.parse(price),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vêtement ajouté avec succès')),
      );

      Navigator.pop(context);
    } catch (e) {
      print('Error saving clothing: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter un vêtement'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                onChanged: (value) => imageUrl = value,
                decoration: const InputDecoration(labelText: 'Lien de l\'image'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un lien d\'image';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _fetchCategory,
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Détecter la catégorie'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                initialValue: category,
                readOnly: true,
                decoration: const InputDecoration(labelText: 'Catégorie'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                onChanged: (value) => title = value,
                decoration: const InputDecoration(labelText: 'Titre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un titre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                onChanged: (value) => size = value,
                decoration: const InputDecoration(labelText: 'Taille'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une taille';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                onChanged: (value) => brand = value,
                decoration: const InputDecoration(labelText: 'Marque'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une marque';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                onChanged: (value) => price = value,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Prix'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un prix';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Veuillez entrer un nombre valide';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveClothing,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                ),
                child: const Text('Valider'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
