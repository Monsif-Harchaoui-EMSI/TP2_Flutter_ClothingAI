import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/clothing_item.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartService {
  /// Fetch cart items for a specific user
  static Future<List<ClothingItem>> getCartItems(String userId) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('cart')
          .where('userId', isEqualTo: userId)
          .get();

      return snapshot.docs.map((doc) {
        return ClothingItem.fromMap(doc.data(), doc.id);
      }).toList();
    } catch (e) {
      print('Error fetching cart items: $e');
      return [];
    }
  }

  /// Add an item to the cart for a specific user
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
        'imageUrl': item.imageUrl,
        'quantity': 1, // Default quantity
      });
      print('${item.title} added to cart for user ${user.uid}.');
    } catch (e) {
      print('Error adding to cart: $e');
    }
  }

  /// Remove an item from the cart
  static Future<void> removeFromCart(String cartItemId) async {
    try {
      await FirebaseFirestore.instance.collection('cart').doc(cartItemId).delete();
      print('Item removed from cart: $cartItemId');
    } catch (e) {
      print('Error removing item from cart: $e');
    }
  }
}
