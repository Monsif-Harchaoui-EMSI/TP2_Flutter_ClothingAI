import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileService {
  /// Fetch user profile details
  static Future<Map<String, dynamic>?> getUserProfile() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('No authenticated user found');
      }

      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: user.uid)
          .get();

      if (snapshot.docs.isEmpty) {
        print('No profile data found for user UID: ${user.uid}');
        return null;
      }

      return snapshot.docs.first.data();
    } catch (e) {
      print('Error fetching profile: $e');
      return null;
    }
  }

  /// Update user profile details
  static Future<void> updateUserProfile(Map<String, dynamic> data) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('No authenticated user found');
      }

      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: user.uid)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final docId = snapshot.docs.first.id;
        await FirebaseFirestore.instance.collection('users').doc(docId).update(data);
        print('Profile updated for user ${user.uid}');
      }
    } catch (e) {
      print('Error updating profile: $e');
    }
  }

  /// Update user password in Firebase Authentication
  static Future<void> updateUserPassword(String newPassword) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('No authenticated user found');
      }

      await user.updatePassword(newPassword);
      print('Password updated for user ${user.uid}');
    } catch (e) {
      print('Error updating password: $e');
    }
  }
}
