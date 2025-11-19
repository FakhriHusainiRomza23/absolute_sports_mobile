import 'package:flutter/material.dart';
import 'package:absolute_sports/screens/menu.dart';
import 'package:absolute_sports/screens/product_form_page.dart';
import 'package:absolute_sports/screens/product_entry_list.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Absolute Sports',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => MyHomePage()),
                  (route) => false,
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.add_circle),
              title: const Text('Add Products'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const ProductFormPage()),
                );
              },
            ),
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
      ),
    );
  }
}
