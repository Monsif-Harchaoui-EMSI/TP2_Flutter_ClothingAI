import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/clothing_item.dart';

class DatabaseService {
  /// Fetch clothing items from Firestore and parse them into a list of `ClothingItem`.
  static Future<List<ClothingItem>> getClothingItems() async {
    try {
      // Fetch all documents from the "clothing" collection
      final snapshot = await FirebaseFirestore.instance.collection('clothing').get();

      // Log raw document data for debugging
      for (var doc in snapshot.docs) {
        print('Raw Firestore data: ${doc.data()}');
      }

      // Parse documents into a list of `ClothingItem`
      return snapshot.docs.map((doc) {
        return ClothingItem.fromMap(doc.data(), doc.id); // Include document ID
      }).toList();
    } catch (e) {
      print('Error fetching clothing items: $e');
      return [];
    }
  }
}
