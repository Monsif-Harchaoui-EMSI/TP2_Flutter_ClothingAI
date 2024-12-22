import 'package:flutter/material.dart';
import '../models/clothing_item.dart';
import '../services/cart_service.dart';

class ClothingDetailScreen extends StatelessWidget {
  final ClothingItem item;

  const ClothingDetailScreen({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détail du vêtement'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Item Image
            item.imageUrl.isNotEmpty
                ? Image.network(
                    item.imageUrl,
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.broken_image, size: 100, color: Colors.grey);
                    },
                  )
                : const Icon(Icons.image_not_supported, size: 100, color: Colors.grey),
            const SizedBox(height: 20),

            // Item Details
            Text(
              item.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('Catégorie : ${item.category}'),
            Text('Taille : ${item.size}'),
            Text('Marque : ${item.brand}'),
            Text('Prix : ${item.price.toStringAsFixed(2)} €'),
            const Spacer(),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Retour Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent, // Brighter color for Retour
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Retour'),
                ),

                // Ajouter au Panier Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Bright green for Add to Cart
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                    // Add item to cart
                    await CartService.addToCart(item);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${item.title} ajouté au panier.')),
                    );
                  },
                  child: const Text('Ajouter au Panier'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
