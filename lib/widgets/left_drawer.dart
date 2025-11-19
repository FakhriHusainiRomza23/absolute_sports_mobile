import 'package:flutter/material.dart';
import 'package:absolute_sports/screens/menu.dart';
import 'package:absolute_sports/screens/product_form_page.dart';
import 'package:absolute_sports/screens/product_entry_list.dart';


class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            // TODO: Bagian drawer header
            decoration: BoxDecoration(
            color: Color.fromARGB(255, 24, 119, 197),
          ),
          child: Column(
            children: [
              Text(
                'Absolute Sports',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Padding(padding: EdgeInsets.all(10)),
              Text("Seluruh Produk Terbaru Terkait Sepak Bola di sini!",
                  // TODO: Tambahkan gaya teks dengan center alignment, font ukuran 15, warna putih, dan weight biasa
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                  ),
            ],
          ),
          ),

          // TODO: Bagian routing, Home
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            // Bagian redirection ke MyHomePage
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ));
            },
          ),

          // routing create product
          ListTile(
            leading: const Icon(Icons.post_add),
            title: const Text('Create Product'),
            // Bagian redirection ke ProductFormPage
            onTap: () {
              /*
              TODO: Buatlah routing ke ProductFormPage di sini,
              setelah halaman ProductFormPage sudah dibuat.
              */
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductFormPage(),
                  ));
            },
          ),

          // routing list produk
          ListTile(
              leading: const Icon(Icons.add_reaction_rounded),
              title: const Text('Product List'),
              onTap: () {
                  // Route to product list page
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ProductEntryListPage()),
                  );
              },
          ),

        ],
      ),
    );
  }
}