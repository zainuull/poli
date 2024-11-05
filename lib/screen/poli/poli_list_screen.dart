import 'package:flutter/material.dart';
import '../../models/poli.dart';
import '../../service/poli_service.dart';
import '../../sidebar.dart';

class PoliListScreen extends StatefulWidget {
  const PoliListScreen({super.key});

  @override
  _PoliListScreenState createState() => _PoliListScreenState();
}

class _PoliListScreenState extends State<PoliListScreen> {
  List<Poli> _poliList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPoliData();
  }

  Future<void> _loadPoliData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      _poliList = 
        await PoliService().getPoli();
    } catch (e) {
      _showErrorDialog(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _deletePoli(int id) async {
    bool? confirmDelete = await _showDeleteConfirmation();
    if (confirmDelete == true) {
      try {
        await PoliService().deletePoli(id);
        _loadPoliData();
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
        title: const Text('List Poli'),
        
      ),
      drawer: Sidebar(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _poliList.isEmpty
              ? const Center(child: Text('No data found'))
              : ListView.builder(
                  itemCount: _poliList.length,
                  itemBuilder: (context, index) {
                    final poli = _poliList[index];
                    return Card(
                      child: ListTile(
                        title: Text(poli.poli),
                        subtitle: Text('ID: ${poli.id}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                Navigator.pushNamed(context, '/edit-poli', arguments: poli)
                                    .then((value) => _loadPoliData());
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _deletePoli(poli.id),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ), 
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add-poli')
              .then((value) => _loadPoliData());
        },
        tooltip: 'Tambah Poli',
        child: Icon(Icons.add),
        ),
    );
  }
}
