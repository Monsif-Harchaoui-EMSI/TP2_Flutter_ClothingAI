import 'package:flutter/material.dart';
import '../models/clothing_item.dart';
import '../services/cart_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<ClothingItem> cartItems = [];
  double totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    _fetchCartItems();
  }

  Future<void> _fetchCartItems() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print('User not logged in');
      return;
    }

    final items = await CartService.getCartItems(user.uid);
    setState(() {
      cartItems = items;
      totalPrice = items.fold(0, (sum, item) => sum + item.price);
    });
  }

  Future<void> _removeItem(String cartItemId) async {
    await CartService.removeFromCart(cartItemId);
    _fetchCartItems(); // Refresh cart after removal
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Votre Panier'),
      ),
      body: cartItems.isEmpty
          ? const Center(child: Text('Votre panier est vide.'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: ListTile(
                          leading: item.imageUrl.isNotEmpty
                              ? Image.network(
                                  item.imageUrl,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(Icons.broken_image, size: 50);
                                  },
                                )
                              : const Icon(Icons.image_not_supported, size: 50),
                          title: Text(item.title),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Taille : ${item.size}'),
                              Text('Prix : ${item.price.toStringAsFixed(2)} €'),
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.close, color: Colors.red),
                            onPressed: () => _removeItem(item.id), // Remove item from cart
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Total Price
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Total Général : ${totalPrice.toStringAsFixed(2)} €',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
