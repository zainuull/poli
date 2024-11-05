import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/pasien.dart';
import '../../service/pasien_service.dart';

class PasienFormScreen extends StatefulWidget {
  final Pasien? pasien;

  const PasienFormScreen({super.key, this.pasien});

  @override
  _PasienFormScreenState createState() => _PasienFormScreenState();
}
class _PasienFormScreenState extends State<PasienFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _nomorTeleponController = TextEditingController();
  final TextEditingController _tanggalLahirController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');
  String _nomorRm = '';

  @override
  void initState() {
    super.initState();
    if (widget.pasien != null) {
      _nomorRm = widget.pasien!.nomor_rm;
      _namaController.text = widget.pasien!.nama;
      _tanggalLahirController.text = widget.pasien!.tanggal_lahir;
      _nomorTeleponController.text = widget.pasien!.nomor_telepon;
      _alamatController.text = widget.pasien!.alamat;
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _tanggalLahirController.text = _dateFormat.format(picked);
      });
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (widget.pasien == null) {
        await PasienService().createPasien(
          _nomorRm,
          _namaController.text,
          _tanggalLahirController.text,
          _nomorTeleponController.text,
          _alamatController.text,
        );
      } else {
        await PasienService().updatePasien(
          widget.pasien!.id,
          _nomorRm,
          _namaController.text,
          _tanggalLahirController.text,
          _nomorTeleponController.text,
          _alamatController.text,
        );
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pasien == null ? 'Add Pasien' : 'Edit Pasien'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _nomorRm,
                decoration: const InputDecoration(labelText: 'Nomor RM'),
                keyboardType: TextInputType.number,
                onChanged: (value) {_nomorRm = value;},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a Nomor RM';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(labelText: 'Nama Pasien'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name for the Pasien';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _tanggalLahirController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Tanggal Lahir',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () {
                  _selectDate(context);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a birth date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nomorTeleponController,
                decoration: const InputDecoration(labelText: 'Nomor Telepon'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _alamatController,
                decoration: const InputDecoration(labelText: 'Alamat'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(widget.pasien == null ? 'Create' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
