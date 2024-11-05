import 'package:flutter/material.dart';
import 'package:poli/screens/poli_form_screen.dart';
import '../models/poli.dart';
import '../services/api_service.dart';
// import 'poli_form_screen.dart';

class PoliListScreen extends StatefulWidget {
  @override
  _PoliListScreenState createState() => _PoliListScreenState();
}

class _PoliListScreenState extends State<PoliListScreen> {
  late Future<List<Poli>> futurePoli;

  @override
  void initState() {
    super.initState();
    futurePoli = ApiService().getPoli(); // Mengambil data poli saat layar ini dimulai
  }

  // Method untuk memperbarui data yang ada di layar
  void _refreshData() {
    setState(() {
      futurePoli = ApiService().getPoli(); // Mengambil ulang data poli
    });
  }
  
  // Method untuk menghapus poli, menampilkan dialog konfirmasi terlebih dahulu
  void _deletePoli(int id) async {
    // Menampilkan dialog konfirmasi sebelum menghapus data poli
    bool? confirmDelete = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Konfirmasi Hapus'),
        content: Text('Apakah Anda yakin ingin menghapus data ini?'),
        actions: [
          // Tombol batal untuk menutup dialog jika tidak jadi menghapus
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Tidak'),
          ),
          // Tombol ya untuk melanjutkan proses penghapusan data
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Ya'),
          ),
        ],
      ),
    );

    // Jika pengguna mengkonfirmasi penghapusan, maka lakukan penghapusan data
    if (confirmDelete == true) {
      await ApiService()
        .deletePoli(id); // Menghapus data poli melalui ApiService
      _refreshData(); // Mengambil ulang data poli untuk memperbarui tampilan
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Poli'),
        actions: [
          // Tombol untuk menambah data poli
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigasi menuju layar form Poli untuk menambahkan data baru
              Navigator.push(context,  MaterialPageRoute(builder: (context) => PoliFormScreen()))
                .then((value) => _refreshData());
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Poli>>(
        future: futurePoli,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Menampilkan indikator loading ketika data sedang diambil
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Menampilkan pesan error jika terjadi kesalahan
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            // Jika ada data, tampilkan dalam bentuk list
            final poliList = snapshot.data!;
            return ListView.builder(
              itemCount: poliList.length,
              itemBuilder: (context, index) {
                final poli = poliList[index];
                return Card(
                  child: ListTile(
                    title: Text(poli.poli), // Menampilkan nama poli
                    subtitle: Text('ID: ${poli.id}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Tombol untuk mengedit data poli
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            // Navigasi menuju layar form Poli untuk mengedit data
                            Navigator.push(context, MaterialPageRoute(builder: (context) => PoliFormScreen(poli: poli))).then((value) => _refreshData());
                          },
                        ),
                        // Tombol untuk menghapus data poli dengan konfirmasi
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _deletePoli(poli.id); // Menghapus poli dengan konfirmasi
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            // Jika tidak ada data yang ditemukan
            return Center(child: Text('No data found'));
          }
        },
      ),
    );
  }
}