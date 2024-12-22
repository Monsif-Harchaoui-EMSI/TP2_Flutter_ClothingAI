import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/clothing_item.dart';

class DatabaseService {
  static Future<List<ClothingItem>> getClothingItems() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('clothing').get();

      // Log raw Firestore document data
      for (var doc in snapshot.docs) {
        print('Raw Firestore data: ${doc.data()}');
      }

      return snapshot.docs.map((doc) {
        final clothingItem = ClothingItem.fromMap(doc.data());

        // Log parsed ClothingItem data
        print('Parsed item: ${clothingItem.title}, ${clothingItem.size}, ${clothingItem.price}');

        return clothingItem;
      }).toList();
    } catch (e) {
      print('Error fetching clothing items: $e');
      return [];
    }
  }
}
