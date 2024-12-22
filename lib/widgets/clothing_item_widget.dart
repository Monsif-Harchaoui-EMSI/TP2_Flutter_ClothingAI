import 'package:flutter/material.dart';
import '../models/clothing_item.dart';

class ClothingItemWidget extends StatelessWidget {
  final ClothingItem item;

  const ClothingItemWidget({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: item.imageUrl.isNotEmpty
            ? Image.network(
                item.imageUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.broken_image,
                    size: 50,
                    color: Colors.grey,
                  );
                },
              )
            : const Icon(
                Icons.image_not_supported,
                size: 50,
                color: Colors.grey,
              ),
        title: Text(item.title),
        subtitle: Text(
          'Taille : ${item.size.isNotEmpty ? item.size : 'Non disponible'}\n'
          'Prix : ${item.price > 0 ? '${item.price} €' : 'Non disponible'}',
        ),
      ),
    );
  }
}
