class ClothingItem {
  final String imageUrl;
  final String title;
  final String size;
  final double price;

  ClothingItem({
    required this.imageUrl,
    required this.title,
    required this.size,
    required this.price,
  });

factory ClothingItem.fromMap(Map<String, dynamic> data) {
  print('Mapping Firestore data: $data');

  return ClothingItem(
    imageUrl: data['imageUrl'] ?? '',
    title: data['title'] ?? 'Titre inconnu',
    size: data['size'] != null && data['size'] is String && data['size'].isNotEmpty
        ? data['size']
        : 'Taille inconnue',
    price: data['price'] != null
        ? (data['price'] is num
            ? (data['price'] as num).toDouble()
            : double.tryParse(data['price'].toString()) ?? 0.0)
        : 0.0,
  );
}
}
