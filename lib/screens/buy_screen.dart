import 'package:flutter/material.dart';
import '../models/clothing_item.dart';
import '../services/database_service.dart';

class BuyScreen extends StatefulWidget {
  @override
  _BuyScreenState createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> {
  List<ClothingItem> items = [];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _fetchClothingItems();
  }

  Future<void> _fetchClothingItems() async {
    final fetchedItems = await DatabaseService.getClothingItems();
    setState(() {
      items = fetchedItems;
    });
  }

  void _showPreviousItem() {
    setState(() {
      currentIndex = (currentIndex - 1 + items.length) % items.length;
    });
  }

  void _showNextItem() {
    setState(() {
      currentIndex = (currentIndex + 1) % items.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Row(
          children: const [
            Icon(Icons.shopping_cart, color: Colors.white),
            SizedBox(width: 10),
            Text('Page Acheter', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
      body: items.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Top Title
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.attach_money, color: Colors.green, size: 30),
                      SizedBox(width: 10),
                      Text(
                        "Page d'Achat",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),

                // Image and Item Details
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      items[currentIndex].imageUrl.isNotEmpty
                          ? Image.network(
                              items[currentIndex].imageUrl,
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.broken_image,
                                  size: 100,
                                  color: Colors.grey,
                                );
                              },
                            )
                          : const Icon(
                              Icons.image_not_supported,
                              size: 100,
                              color: Colors.grey,
                            ),
                      const SizedBox(height: 20),
                      Text(
                        items[currentIndex].title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text('Taille : ${items[currentIndex].size}'),
                      Text('Prix : ${items[currentIndex].price.toStringAsFixed(2)} €'),
                    ],
                  ),
                ),

                // Navigation Arrows
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_left, size: 40, color: Colors.teal),
                      onPressed: _showPreviousItem,
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_right, size: 40, color: Colors.teal),
                      onPressed: _showNextItem,
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
