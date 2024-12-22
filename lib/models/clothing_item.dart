class ClothingItem {
  final String id; // Unique ID for the item
  final String imageUrl;
  final String title;
  final String size;
  final double price;
  final String category;
  final String brand;

  ClothingItem({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.size,
    required this.price,
    required this.category,
    required this.brand,
  });

  factory ClothingItem.fromMap(Map<String, dynamic> data, String id) {
    return ClothingItem(
      id: id,
      imageUrl: data['imageUrl'] ?? '',
      title: data['title'] ?? 'Titre inconnu',
      size: data['size'] ?? 'Taille inconnue',
      price: data['price'] != null ? (data['price'] as num).toDouble() : 0.0,
      category: data['category'] ?? 'Catégorie inconnue',
      brand: data['brand'] ?? 'Marque inconnue',
    );
  }
}
