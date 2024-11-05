import 'package:flutter/material.dart';
import '../../models/pasien.dart';
import '../../service/pasien_service.dart';
import '../../sidebar.dart';

class PasienListScreen extends StatefulWidget {
  const PasienListScreen({super.key});

  @override
  _PasienListScreenState createState() => _PasienListScreenState();
}

class _PasienListScreenState extends State<PasienListScreen> {
  List<Pasien> _pasienList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPasienData();
  }

  Future<void> _loadPasienData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      _pasienList = await PasienService().getPasien();
    } catch (e) {
      _showErrorDialog(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _deletePasien(int id) async {
    bool? confirmDelete = await _showDeleteConfirmation();
    if (confirmDelete == true) {
      try {
        await PasienService().deletePasien(id);
        _loadPasienData();
      } catch (e) {
        _showErrorDialog(e.toString());
      }
    }
  }

  Future<bool?> _showDeleteConfirmation() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Hapus'),
        content: const Text('Apakah Anda yakin ingin menghapus data ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Tidak'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Ya'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Pasien'),
      ),
      drawer: Sidebar(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _pasienList.isEmpty
              ? const Center(child: Text('No data found'))
              : ListView.builder(
                  itemCount: _pasienList.length,
                  itemBuilder: (context, index) {
                    final pasien = _pasienList[index];
                    return Card(
                      child: ListTile(
                        title: Text(pasien.nama),
                        subtitle: Text('Nomor RM: ${pasien.nomor_rm} | ID: ${pasien.id}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                Navigator.pushNamed(context, '/edit-pasien', arguments: pasien).then((value) => _loadPasienData());
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _deletePasien(pasien.id),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add-pasien').then((value) => _loadPasienData());
        },
        tooltip: 'Tambah Pasien',
        child: Icon(Icons.add),
      ),
    );
  }
}
