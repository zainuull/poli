import 'package:flutter/material.dart'; // Library utama untuk UI di Flutter
import '../../models/poli.dart'; // Mengimpor model Poli
import '../../services/poli_service.dart'; // Mengimpor PoliService untuk operasi data

class PoliFormScreen extends StatefulWidget {
  final Poli? poli; // Data poli yang mungkin diisi untuk edit

  PoliFormScreen({this.poli});

  @override
  _PoliFormScreenState createState() => _PoliFormScreenState();
}

class _PoliFormScreenState extends State<PoliFormScreen> {
  final _formKey = GlobalKey<FormState>(); // Kunci unik untuk form
  final TextEditingController _poliController = TextEditingController(); // Controller untuk input nama poli

  @override
  void initState() {
    super.initState();

    if (widget.poli != null) {
      // Jika mode edit, isi controller dengan data yang ada
      _poliController.text = widget.poli!.poli;
    }
  }
  
  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Jika validasi form berhasil
      if (widget.poli == null) {
        // Jika tidak ada data poli, tambahkan baru
        await PoliService().createPoli(_poliController.text);
      } else {
        // Jika ada data poli, lakukan update
        await PoliService().updatePoli(widget.poli!.id, _poliController.text);
      }
      Navigator.pop(context); // Kembali ke layar sebelumnya setelah submit
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.poli == null ? 'Add Poli' : 'Edit Poli'), // Menampilkan judul sesuai mode (tambah/edit)
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _poliController,
                decoration: InputDecoration(labelText: 'Nama Poli'), // Input untuk nama poli
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name for the Poli'; // Validasi input kosong
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm, // Tombol submit
                child: Text(widget.poli == null ? 'Create' : 'Update'), // Menampilkan teks tombol sesuai mode
              ),
            ],
          ),
        ),
      ),
    );
  }
}