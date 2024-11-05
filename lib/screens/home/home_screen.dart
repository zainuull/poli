import 'package:flutter/material.dart';
import '../../sidebar.dart';
import 'navigation_tile.dart'; // Widget untuk kotak navigasi

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Klinik App'), // Judul AppBar
      ),
      drawer: Sidebar(), // Menampilkan drawer navigasi
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2, // Menampilkan dua kotak dalam satu baris
          crossAxisSpacing: 10.0, // Jarak antar kolom
          mainAxisSpacing: 10.0, // Jarak antar baris
          children: <Widget>[
            NavigationTile(
              title: 'Poli', // Tile untuk navigasi ke daftar poli
              icon: Icons.local_hospital,
              color: Colors.blue,
              onTap: () => Navigator.pushNamed(context, '/list-poli'),
            ),
            NavigationTile(
              title: 'Pegawai', // Tile untuk navigasi ke daftar pegawai
              icon: Icons.people,
              color: Colors.green,
              onTap: () => Navigator.pushNamed(context, '/list-poli'),
            ),
            NavigationTile(
              title: 'Pasien', // Tile untuk navigasi ke daftar pasien
              icon: Icons.person,
              color: Colors.orange,
              onTap: () => Navigator.pushNamed(context, '/list-poli'),
            ),
          ],
        ),
      ),
    );
  }
}