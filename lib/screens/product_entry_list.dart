
import 'package:flutter/material.dart';
import 'package:absolute_sports/models/product_entry.dart';
import 'package:absolute_sports/widgets/left_drawer.dart';
// import 'package:absolute_sports/screens/product_detail.dart';
import 'package:absolute_sports/widgets/product_entry_card.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:absolute_sports/screens/product_detail.dart';

class ProductEntryListPage extends StatefulWidget {
  const ProductEntryListPage({super.key, this.showOnlyMine = false});

  final bool showOnlyMine;

  @override
  State<ProductEntryListPage> createState() => _ProductEntryListPageState();
}

class _ProductEntryListPageState extends State<ProductEntryListPage> {
  Future<List<ProductEntry>> fetchProduct(CookieRequest request) async {
    // TODO: Replace the URL with your app's URL and don't forget to add a trailing slash (/)!
    // To connect Android emulator with Django on localhost, use URL http://10.0.2.2/
    // If you using chrome,  use URL http://localhost:8000
    
    final response = await request.get('http://localhost:8000/json/');
    
    // Decode response to json format
    var data = response;
    
    // Convert json data to ProductEntry objects
    List<ProductEntry> listProduct = [];
    for (var d in data) {
      if (d != null) {
        listProduct.add(ProductEntry.fromJson(d));
      }
    }
    // Optionally filter to only current user's items
    if (widget.showOnlyMine) {
      final jd = request.jsonData;
      final String? currentUsername = jd['username']?.toString();

      if (currentUsername != null) {
        listProduct = listProduct
            .where((p) => (p.userUsername ?? '').toLowerCase() == currentUsername.toLowerCase())
            .toList();
      } else {
        final dynamic idCandidate = jd['id'] ?? jd['user_id'] ?? jd['userId'] ??
            (jd['user'] is Map ? jd['user']['id'] : null) ?? jd['pk'];
        int? currentUserId;
        if (idCandidate is int) {
          currentUserId = idCandidate;
        } else if (idCandidate != null) {
          currentUserId = int.tryParse(idCandidate.toString());
        }
        if (currentUserId != null) {
          listProduct = listProduct.where((p) => p.userId == currentUserId).toList();
        }
      }
    }
    return listProduct;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Entry List'),
      ),
      drawer: const LeftDrawer(),
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
                    'There are no product in Absolute Sports.',
                    style: TextStyle(fontSize: 20, color: Color(0xff59A5D8)),
                  ),
                  SizedBox(height: 8),
                ],
              );
            } else {
              if (snapshot.data!.isEmpty) {
                return Center(
                  child: Text(
                    widget.showOnlyMine
                        ? 'You have no products yet.'
                        : 'No products available.',
                    style: const TextStyle(fontSize: 16),
                  ),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => ProductEntryCard(
                  product: snapshot.data![index],
                  onTap: () {
                    
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
