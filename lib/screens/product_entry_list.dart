import 'package:flutter/material.dart';
import 'package:absolute_sports/models/product_entry.dart';
import 'package:absolute_sports/widgets/app_drawer.dart';
import 'package:absolute_sports/screens/product_detail.dart';
import 'package:absolute_sports/widgets/product_entry_card.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform, TargetPlatform;

class ProductEntryListPage extends StatefulWidget {
  final bool onlyMine;

  const ProductEntryListPage({super.key, this.onlyMine = false});

  @override
  State<ProductEntryListPage> createState() => _ProductEntryListPageState();
}

class _ProductEntryListPageState extends State<ProductEntryListPage> {
  String _baseUrl() {
    if (kIsWeb) return 'http://localhost:8000';
    if (defaultTargetPlatform == TargetPlatform.android) return 'http://10.0.2.2:8000';
    return 'http://localhost:8000';
  }

  Future<List<ProductEntry>> fetchProduct(CookieRequest request) async {
    // TODO: Replace the URL with your app's URL and don't forget to add a trailing slash (/)!
    // To connect Android emulator with Django on localhost, use URL http://10.0.2.2/
    // If you using chrome,  use URL http://localhost:8000
    
    final response = await request.get('${_baseUrl()}/json/');
    
    // Decode response to json format
    var data = response;
    
    // Convert json data to ProductEntry objects
    List<ProductEntry> listProduct = [];
    for (var d in data) {
      if (d != null) {
        listProduct.add(ProductEntry.fromJson(d));
      }
    }
    // Optional filter: only items belonging to the logged-in user
    if (widget.onlyMine) {
      try {
        final userId = request.jsonData['id'] ?? request.jsonData['user_id'];
        if (userId is int) {
          listProduct = listProduct.where((p) => p.userId == userId).toList();
        }
      } catch (_) {
        // If no user info available, fall back to full list
      }
    }
    return listProduct;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.onlyMine ? 'My Products' : 'All Products'),
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: fetchProduct(request),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData) {
              return const Column(
                children: [
                  Text(
                    'There are no products in Absolute Sports yet.',
                    style: TextStyle(fontSize: 20, color: Color(0xff59A5D8)),
                  ),
                  SizedBox(height: 8),
                ],
              );
            } else {
              return ListView.builder(
  itemCount: snapshot.data!.length,
  itemBuilder: (_, index) => ProductEntryCard(
    product: snapshot.data![index],
    onTap: () {
      // Navigate to product detail page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailPage(
            product: snapshot.data![index],
          ),
        ),
      );
    },
  ),
);
            }
          }
        },
      ),
    );
  }
}