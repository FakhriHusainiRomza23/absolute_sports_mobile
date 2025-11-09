import 'package:flutter/material.dart';
import 'package:absolute_sports/app_drawer.dart';

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

  void _showSummaryDialog() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Produk Tersimpan'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text('Name: ${_nameController.text}'),
                Text('Price: ${_priceController.text}'),
                Text('Description: ${_descriptionController.text}'),
                Text('Thumbnail: ${_thumbnailController.text}'),
                Text('Category: ${_category ?? '-'}'),
                Text('Featured: ${_isFeatured ? 'Ya' : 'Tidak'}'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  bool _isValidUrl(String value) {
    final uri = Uri.tryParse(value);
    return uri != null && uri.hasAbsolutePath && (uri.isScheme('http') || uri.isScheme('https'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Produk'),
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
                  onPressed: () {
                    if (_formKey.currentState?.validate() == true) {
                      _showSummaryDialog();
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
