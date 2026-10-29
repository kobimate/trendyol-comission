import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});
  @override Widget build(BuildContext context) => Card(margin: const EdgeInsets.only(bottom: 14), clipBehavior: Clip.antiAlias, child: Padding(padding: const EdgeInsets.all(12), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [ClipRRect(borderRadius: BorderRadius.circular(12), child: SizedBox(width: 105, height: 125, child: product.image.isEmpty ? const Icon(Icons.image_not_supported) : CachedNetworkImage(imageUrl: product.image, fit: BoxFit.cover, placeholder: (_, __) => const Center(child: CircularProgressIndicator()), errorWidget: (_, __, ___) => const Icon(Icons.broken_image)))), const SizedBox(width: 14), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(product.name, maxLines: 3, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w700)), const SizedBox(height: 8), Text('${product.priceText} ${product.currency}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)), const SizedBox(height: 5), Text('Kategori #${product.categoryId}  •  ★ ${product.rating.toStringAsFixed(1)}'), Text('Sipariş: ${product.orderCount}'), const SizedBox(height: 7), Text('Komisyon: %${product.commission.toStringAsFixed(1)}  |  Eline geçen: ${product.netAmount().toStringAsFixed(2)} ${product.currency}', style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.green)), ]))]));
}
