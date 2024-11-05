import 'package:flutter/material.dart'; // Library utama untuk UI di Flutter
import '../../models/poli.dart'; // Mengimpor model Poli
import '../../services/poli_service.dart'; // Mengimpor PoliService untuk operasi data
import '../../sidebar.dart'; // Mengimpor Sidebar untuk navigasi aplikasi

class PoliListScreen extends StatefulWidget {
  @override
  _PoliListScreenState createState() => _PoliListScreenState();
}

class _PoliListScreenState extends State<PoliListScreen> {
  List<Poli> _poliList = []; // List untuk menyimpan data Poli
  bool _isLoading = true; // Status untuk menampilkan loading

  @override
  void initState() {
    super.initState();
    _loadPoliData(); // Memuat data Poli saat inisialisasi
  }

  Future<void> _loadPoliData() async {
    setState(() {
      _isLoading = true; // Mengubah status menjadi loading
    });
    
    try {
      _poliList = await PoliService().getPoli(); // Mendapatkan data Poli dari server
    } catch (e) {
      _showErrorDialog(e.toString()); // Menampilkan pesan error jika gagal
    } finally {
      setState(() {
        _isLoading = false; // Mengubah status menjadi tidak loading
      });
    }
  }

  void _deletePoli(int id) async {
    bool? confirmDelete = await _showDeleteConfirmation();
    if (confirmDelete == true) {
      try {
        await PoliService().deletePoli(id); // Menghapus data Poli
        _loadPoliData(); // Memperbarui data setelah penghapusan
      } catch (e) {
        _showErrorDialog(e.toString()); // Menampilkan pesan error jika gagal
      }
    }
  }

  Future<bool?> _showDeleteConfirmation() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Konfirmasi Hapus'),
        content: Text('Apakah Anda yakin ingin menghapus data ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Tidak'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Ya'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Poli'), // Judul AppBar
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/add-poli').then((value) => _loadPoliData()); // Memuat ulang data setelah penambahan
            },
          ),
        ],
      ),
      drawer: Sidebar(), // Menampilkan drawer navigasi
      body: _isLoading
        ? Center(child: CircularProgressIndicator()) // Menampilkan loading jika data sedang dimuat
        : _poliList.isEmpty
          ? Center(child: Text('No data found')) // Menampilkan pesan jika data kosong
          : ListView.builder(
            itemCount: _poliList.length,
            itemBuilder: (context, index) {
              final poli = _poliList[index];
              return Card(
                child: ListTile(
                  title: Text(poli.poli), // Menampilkan nama Poli
                  subtitle: Text('ID: ${poli.id}'), // Menampilkan ID Poli
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Navigator.pushNamed(context, '/edit-poli', arguments: poli).then((value) => _loadPoliData()); // Memuat ulang data setelah edit
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deletePoli(poli.id), // Menghapus Poli
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
    );
  }
}