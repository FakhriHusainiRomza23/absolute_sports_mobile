import 'package:flutter/material.dart';
import 'package:absolute_sports/widgets/app_drawer.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:absolute_sports/screens/menu.dart';
import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform, TargetPlatform;

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _thumbnailController = TextEditingController();

  // Additional fields
  String? _category; // example category
  bool _isFeatured = false;

  // Simple categories placeholder
  final List<String> _categories = ['Jersey', 'Sepatu', 'Bola', 'Aksesoris'];

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _thumbnailController.dispose();
    super.dispose();
  }

  // Removed local summary dialog (replaced by server POST SnackBar feedback)

  bool _isValidUrl(String value) {
    final uri = Uri.tryParse(value);
    return uri != null && uri.hasAbsolutePath && (uri.isScheme('http') || uri.isScheme('https'));
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Products'),
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Name tidak boleh kosong';
                  }
                  if (value.trim().length < 3) {
                    return 'Minimal 3 karakter';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: 'Price',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Price tidak boleh kosong';
                  }
                  final num? parsed = num.tryParse(value);
                  if (parsed == null) {
                    return 'Price harus angka';
                  }
                  if (parsed <= 0) {
                    return 'Price harus lebih dari 0';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Description tidak boleh kosong';
                  }
                  if (value.trim().length < 10) {
                    return 'Minimal 10 karakter';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _thumbnailController,
                decoration: const InputDecoration(
                  labelText: 'Thumbnail URL',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.url,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Thumbnail tidak boleh kosong';
                  }
                  if (!_isValidUrl(value.trim())) {
                    return 'Format URL tidak valid (harus http/https)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                items: _categories
                    .map((c) => DropdownMenuItem<String>(value: c, child: Text(c)))
                    .toList(),
                onChanged: (val) => setState(() => _category = val),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Category harus dipilih';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Featured'),
                value: _isFeatured,
                onChanged: (val) => setState(() => _isFeatured = val),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text('Save'),
                  onPressed: () async {
                    if (_formKey.currentState?.validate() != true) return;

                    // Collect values
                    final name = _nameController.text.trim();
                    final price = int.parse(_priceController.text.trim());
                    final description = _descriptionController.text.trim();
                    final thumbnail = _thumbnailController.text.trim();
                    final category = _category;
                    final isFeatured = _isFeatured;

                    // Platform-aware base URL (tutorial style)
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

                    try {
                      final response = await request.postJson(
                        '$base/create-flutter/',
                        jsonEncode({
                          'name': name,
                          'price': price,
                          'description': description,
                          'thumbnail': thumbnail,
                          'category': category,
                          'is_featured': isFeatured,
                        }),
                      );

                      if (!mounted) return;
                      if (response['status'] == 'success') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Product successfully saved!')),
                        );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => MyHomePage()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(response['message'] ?? 'Something went wrong, please try again.')),
                        );
                      }
                    } on FormatException catch (fe) {
                      if (!mounted) return;
                      // Likely HTML received instead of JSON
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Format error (HTML/non-JSON response). Periksa view Django: ${fe.message}')),
                      );
                    } catch (e) {
                      if (!mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Request failed: $e')),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
