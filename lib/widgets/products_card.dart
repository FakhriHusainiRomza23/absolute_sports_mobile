import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform, TargetPlatform;
import 'package:absolute_sports/screens/product_form_page.dart';
import 'package:absolute_sports/screens/menu.dart';
import 'package:absolute_sports/screens/product_entry_list.dart';
import 'package:absolute_sports/screens/login.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ItemCard extends StatelessWidget {
  // Menampilkan kartu dengan ikon dan nama.

  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
        final request = context.watch<CookieRequest>();

    return Material(
      // Menentukan warna latar belakang berdasarkan item.
      color: item.color,
      // Membuat sudut kartu melengkung.
      borderRadius: BorderRadius.circular(12),

      child: InkWell(
        onTap: () async {
          // Platform-aware base URL for auth endpoints
          String base;
          if (kIsWeb) {
            base = 'http://localhost:8000';
          } else {
            switch (defaultTargetPlatform) {
              case TargetPlatform.android:
                base = 'http://10.0.2.2:8000';
                break;
              default:
                base = 'http://localhost:8000';
            }
          }

          if (item.name == 'Create Product' || item.name == 'Tambah Produk') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProductFormPage()),
            );
          } else if (item.name == 'See Absolute Sports Products' || item.name == 'All Products') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProductEntryListPage()),
            );
          } else if (item.name == 'My Products') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProductEntryListPage(onlyMine: true)),
            );
          } else if (item.name == 'Logout') {
            final response = await request.logout('$base/auth/logout/');
            final message = response['message'] ?? 'Logout response unknown';
            if (!context.mounted) return;
            if (response['status'] == true) {
              final uname = response['username'] ?? '';
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('$message See you again, $uname.')),
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message)),
              );
            }
          } else {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text(item.message)),
              );
          }
        },
        // Container untuk menyimpan Icon dan Text
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              // Menyusun ikon dan teks di tengah kartu.
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}