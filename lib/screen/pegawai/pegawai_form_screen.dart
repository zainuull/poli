import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/pegawai.dart';
import '../../service/pegawai_service.dart';

class PegawaiFormScreen extends StatefulWidget {
  final Pegawai? pegawai;

  const PegawaiFormScreen({super.key, this.pegawai});

  @override
  _PegawaiFormScreenState createState() => _PegawaiFormScreenState();
}

class _PegawaiFormScreenState extends State<PegawaiFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nipController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _tanggalLahirController = TextEditingController();
  final TextEditingController _nomorTeleponController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final DateFormat _dateFormat = DateFormat('dd-MM-yyyy');

  @override
  void initState() {
    super.initState();
    if (widget.pegawai != null) {
      _nipController.text = widget.pegawai!.nip;
      _namaController.text = widget.pegawai!.nama;
      _tanggalLahirController.text = widget.pegawai!.tanggal_lahir;
      _nomorTeleponController.text = widget.pegawai!.nomor_telepon;
      _emailController.text = widget.pegawai!.email;
      _passwordController.text = widget.pegawai!.password;
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
      if (widget.pegawai == null) {
        await PegawaiService().createPegawai(
          _nipController.text,
          _namaController.text,
          _tanggalLahirController.text,
          _nomorTeleponController.text,
          _emailController.text,
          _passwordController.text,
        );
      } else {
        await PegawaiService().updatePegawai(
          widget.pegawai!.id,
          _nipController.text,
          _namaController.text,
          _tanggalLahirController.text,
          _nomorTeleponController.text,
          _emailController.text,
          _passwordController.text,
        );
      }
      Navigator.pop(context);
    }
  }

  Future<void> _showErrorDialog(String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pegawai == null ? 'Add Pegawai' : 'Edit Pegawai'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nipController,
                decoration: const InputDecoration(labelText: 'NIP'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter NIP';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama Pegawai',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter name';
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
                    return 'Please enter birth date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nomorTeleponController,
                decoration: const InputDecoration(
                  labelText:
                      'Nomor Telepon',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email';
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(widget.pegawai == null
                    ? 'Create'
                    : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
