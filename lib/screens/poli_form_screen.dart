import 'package:flutter/material.dart';
import '../models/poli.dart';
import '../services/api_service.dart';

class PoliFormScreen extends StatefulWidget {
  final Poli? poli;

  PoliFormScreen({this.poli});

  @override
  _PoliFormScreenState createState() => _PoliFormScreenState();
}

class _PoliFormScreenState extends State<PoliFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _poliController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.poli != null) {
      _poliController.text = widget.poli!.poli; // Jika edit, isi data dengan data yang ada
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (widget.poli == null) {
        // Jika tidak ada data poli, tambahkan baru
        await ApiService().createPoli(_poliController.text);
      } else {
        // Jika ada data poli, lakukan update
        await ApiService().updatePoli(widget.poli!.id, _poliController.text);
      }
      Navigator.pop(context); // Kembali ke layar sebelumnya setelah submit
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.poli == null ? 'Add Poli' : 'Edit Poli'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _poliController,
                decoration: InputDecoration(labelText: 'Nama Poli'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name for the Poli';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(widget.poli == null ? 'Create' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}