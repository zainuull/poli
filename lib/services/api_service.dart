import 'dart:convert'; // Untuk mengubah data dari JSON
import 'package:http/http.dart' as http;
import '../models/poli.dart';

class ApiService {
  static const String baseUrl = 'https://apiklinik.kelasprojek.com/poli';

  // Fungsi untuk mendapatkan data dari server
  Future<List<Poli>> getPoli() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      // Jika respons berhasil, kita mengubah data dari JSON menjadi List objek Poli
      final data = jsonDecode(response.body);
      final List<dynamic> poliList = data['data'];
      
      return poliList.map((json) => Poli.fromJson(json)).toList();
    } else {
      throw Exception(
        'Failed to load data'); // Jika gagal, kita tampilkan pesan error
    }
  }

  // Fungsi untuk menambahkan data poli baru
  Future<void> createPoli(String poliName) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json'
      }, // Memberitahu server bahwa data kita berbentuk JSON
      body: jsonEncode({'poli': poliName}),
    );
    
    if (response.statusCode != 201) {
      throw Exception('Failed to create poli');
    }
  }

  // Fungsi untuk memperbarui data poli
  Future<void> updatePoli(int id, String poliName) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'poli': poliName}),
    );
  
    if (response.statusCode != 200) {
      throw Exception('Failed to update poli');
    }
  }

  // Fungsi untuk menghapus data poli
  Future<void> deletePoli(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete poli');
    }
  }
}