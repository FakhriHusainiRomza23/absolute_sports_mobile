import 'package:flutter/material.dart';
import 'package:absolute_sports/models/product_entry.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductEntry product;

  const ProductDetailPage({super.key, required this.product});

  String _formatDate(DateTime date) {
    // Simple date formatter without intl package
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 
                    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${date.day} ${months[date.month - 1]} ${date.year}, ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  String formatRupiah(num price, {String symbol = 'Rp'}) {
  final formatted = price.toStringAsFixed(0).replaceAll(',', '.');
  return '$symbol $formatted';
}

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    int? _extractUserId(Map<String, dynamic> jd) {
      final dynamic idCandidate = jd['id'] ?? jd['user_id'] ?? jd['userId'] ??
          (jd['user'] is Map ? jd['user']['id'] : null) ?? jd['pk'];
      if (idCandidate is int) return idCandidate;
      return idCandidate != null ? int.tryParse(idCandidate.toString()) : null;
    }

    final Map<String, dynamic> jd = Map<String, dynamic>.from(request.jsonData);
    final int? currentUserId = _extractUserId(jd);
    final String? currentUsername = jd['username']?.toString();
    final bool isMine = (product.userUsername != null && currentUsername != null
      ? product.userUsername!.toLowerCase() == currentUsername.toLowerCase()
      : (product.userId != null && currentUserId != null && product.userId == currentUserId));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail image
            if (product.thumbnail?.isNotEmpty ?? false)
              Image.network(
                'http://localhost:8000/proxy-image/?url=${Uri.encodeComponent(product.thumbnail!)}',
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 250,
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.broken_image, size: 50),
                  ),
                ),
              ),
            
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Featured badge
                  if (product.isFeatured)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 6.0),
                      margin: const EdgeInsets.only(bottom: 12.0),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: const Text(
                        'Featured',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),

                  // Title
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Category and Date
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          color: Colors.indigo.shade100,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Text(
                          product.category.toUpperCase(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo.shade700,
                          ),
                        ),
                      ),
                      
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Price
                  Row(
                    children: [
                      const Icon(Icons.sell, size: 16),
                      const SizedBox(width: 6),
                      Text(
                        '${formatRupiah(product.price)}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Owner info
                  Row(
                    children: [
                      const Icon(Icons.person, size: 16),
                      const SizedBox(width: 6),
                      Text(
                        product.userUsername != null
                            ? (isMine ? 'Owner: You' : 'Owner: ${product.userUsername}')
                            : (product.userId != null
                                ? (isMine ? 'Owner: You' : 'Owner ID: ${product.userId}')
                                : 'Owner: Unknown'),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                  
                  const Divider(height: 32),

                  // Full content
                  Text(
                    product.description,
                    style: const TextStyle(
                      fontSize: 16.0,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}