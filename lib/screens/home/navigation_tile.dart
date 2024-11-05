import 'package:flutter/material.dart';

class NavigationTile extends StatelessWidget {
  final String title; // Judul yang ditampilkan pada tile
  final IconData icon; // Ikon yang ditampilkan pada tile
  final Color color; // Warna background tile
  final VoidCallback onTap; // Fungsi yang dijalankan saat tile ditekan

  NavigationTile({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Menjalankan fungsi ketika tile ditekan
      child: Container(
        decoration: BoxDecoration(
          color: color, // Mengatur warna latar belakang
          borderRadius: BorderRadius.circular(10), // Mengatur sudut melengkung
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Mengatur posisi konten di tengah
          children: [
            Icon(icon, size: 50, color: Colors.white), // Menampilkan ikon
            SizedBox(height: 10),
            Text(
              title, // Menampilkan judul
              style: TextStyle(
                color: Colors.white, // Warna teks putih
                fontSize: 18, // Ukuran font teks
                fontWeight: FontWeight.bold, // Teks tebal
              ),
            ),
          ],
        ),
      ),
    );
  }
}