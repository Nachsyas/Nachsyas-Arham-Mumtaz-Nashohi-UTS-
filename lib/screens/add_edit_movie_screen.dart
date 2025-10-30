

import 'package:flutter/material.dart';
import 'package:myapp/model/movie_model.dart';

class AddEditMovieScreen extends StatefulWidget {
  final Movie? movieToEdit;

  const AddEditMovieScreen({super.key, this.movieToEdit});

  @override
  State<AddEditMovieScreen> createState() => _AddEditMovieScreenState();
}

class _AddEditMovieScreenState extends State<AddEditMovieScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _posterUrlController;
  late TextEditingController _synopsisController;
  late TextEditingController _ratingController;

  bool get _isEditing => widget.movieToEdit != null;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.movieToEdit?.title ?? '');
    _posterUrlController = TextEditingController(text: widget.movieToEdit?.posterURL ?? '');
    _synopsisController = TextEditingController(text: widget.movieToEdit?.synopsis ?? '');
    _ratingController = TextEditingController(text: widget.movieToEdit?.rating.toString() ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _posterUrlController.dispose();
    _synopsisController.dispose();
    _ratingController.dispose();
    super.dispose();
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final newMovieData = Movie(
        id: widget.movieToEdit?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        posterURL: _posterUrlController.text,
        synopsis: _synopsisController.text,
        rating: double.tryParse(_ratingController.text) ?? 0.0,
      );
      Navigator.pop(context, newMovieData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Film' : 'Tambah Film Baru'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveForm,
            tooltip: 'Simpan Film',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Judul Film'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Judul tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _posterUrlController,
                decoration: const InputDecoration(labelText: 'URL Poster Gambar'),
                 validator: (value) {
                  if (value == null || value.isEmpty || !Uri.tryParse(value)!.isAbsolute) {
                    return 'Masukkan URL gambar yang valid';
                  }
                  return null;
                },
              ),
               const SizedBox(height: 12),
              TextFormField(
                controller: _synopsisController,
                decoration: const InputDecoration(labelText: 'Sinopsis'),
                maxLines: 4,
                validator: (value) {
                   if (value == null || value.isEmpty) {
                    return 'Sinopsis tidak boleh kosong';
                  }
                  return null;
                },
              ),
               const SizedBox(height: 12),
              TextFormField(
                controller: _ratingController,
                decoration: const InputDecoration(labelText: 'Rating (contoh: 8.5)'),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                 validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Rating tidak boleh kosong';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Masukkan angka yang valid';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _saveForm,
                child: Text(_isEditing ? 'Simpan Perubahan' : 'Tambah Film'),
              )
            ],
          ),
        ),
      ),
    );
  }
}