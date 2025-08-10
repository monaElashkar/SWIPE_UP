import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/models/product_model.dart';
import '../cubit/product_cubit.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _priceController = TextEditingController();
  File? _image;

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => _image = File(picked.path));
  }

  void _submit() {
    final name = _nameController.text;
    final desc = _descController.text;
    final price = double.tryParse(_priceController.text) ?? 0.0;

    final product = ProductModel(
      id: '',
      name: name,
      description: desc,
      price: price,
      createdAt: DateTime.now(),
    );

    context.read<ProductCubit>().addProductWithImage(product, _image);
    Navigator.pop(context);
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Product")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            if (_image != null) Image.file(_image!, height: 150),
            ElevatedButton(onPressed: _pickImage, child: const Text("Pick Image")),
            TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Name')),
            TextField(controller: _descController, decoration: const InputDecoration(labelText: 'Description')),
            TextField(controller: _priceController, decoration: const InputDecoration(labelText: 'Price'), keyboardType: TextInputType.number),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _submit, child: const Text("Submit")),
          ],
        ),
      ),
    );
  }
}
