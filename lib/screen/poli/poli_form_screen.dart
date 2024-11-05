import 'package:flutter/material.dart';
import '../../models/poli.dart';
import '../../service/poli_service.dart';

class PoliFormScreen extends StatefulWidget {
  final Poli? poli;

  const PoliFormScreen({super.key, this.poli});

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
      _poliController.text = widget.poli!.poli;
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (widget.poli == null) {
        await PoliService().createPoli(_poliController.text);
      } else {
        await PoliService().updatePoli(widget.poli!.id, _poliController.text);
      }
      Navigator.pop(context);
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
                decoration: const InputDecoration(
                  labelText: 'Nama Poli',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name for the Poli';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
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
