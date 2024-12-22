import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/clothing_item.dart';

class CartService {
  static Future<void> addToCart(ClothingItem item) async {
    try {
      // Get the current user's ID
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('User not logged in');
      }

      final cartRef = FirebaseFirestore.instance.collection('cart').doc();
      await cartRef.set({
        'userId': user.uid, // Use the authenticated user's ID
        'clothingId': item.id,
        'title': item.title,
        'size': item.size,
        'price': item.price,
        'category': item.category,
        'brand': item.brand,
        'quantity': 1,
      });
      print('${item.title} added to cart for user ${user.uid}.');
    } catch (e) {
      print('Error adding to cart: $e');
    }
  }
}
