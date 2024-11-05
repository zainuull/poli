import 'dart:convert'; // Untuk mengubah data dari JSON
import 'package:http/http.dart' as http; // Library HTTP untuk melakukan request ke server
import '../models/poli.dart'; // Mengimpor model Poli untuk digunakan di dalam service
import 'constant.dart'; // Mengimpor konstanta, termasuk baseUrl

class PoliService {
  static const String endpoint = '$baseUrl/poli'; // URL endpoint untuk resource Poli
  
  // Fungsi untuk mendapatkan data dari server
  Future<List<Poli>> getPoli() async {
    final response = await http.get(Uri.parse(endpoint));
  
    if (response.statusCode == 200) {  
      // Jika respons berhasil, mengubah data dari JSON menjadi List objek Poli
      final data = jsonDecode(response.body);
      final List<dynamic> poliList = data['data'];

      return poliList.map((json) => Poli.fromJson(json)).toList();
    } else {
      // Jika gagal, alihkan ke Exception
      throw Exception('Failed to load data');
    }
  }

  // Fungsi untuk menambahkan data poli baru
  Future<void> createPoli(String poliName) async {
    final response = await http.post(
      Uri.parse(endpoint),
      headers: {
        'Content-Type': 'application/json'
      }, // Memberitahu server bahwa data berbentuk JSON
      body: jsonEncode({'poli': poliName}), // Mengubah data menjadi format JSON
    );

    if (response.statusCode != 201) {
      // Jika respons bukan 201 (Created), alihkan ke Exception
      throw Exception('Failed to create poli');
    }
  }

  // Fungsi untuk memperbarui data poli
  Future<void> updatePoli(int id, String poliName) async {
    final response = await http.put(
      Uri.parse('$endpoint/$id'),
      headers: {
        'Content-Type': 'application/json'
      }, // Memberitahu server bahwa data berbentuk JSON
      body: jsonEncode({'poli': poliName}), // Mengubah data menjadi format JSON
    );

    if (response.statusCode != 200) {
      // Jika respons bukan 200 (OK), alihkan ke Exception
      throw Exception('Failed to update poli');
    }
  }

  // Fungsi untuk menghapus data poli
  Future<void> deletePoli(int id) async {
    final response = await http.delete(Uri.parse('$endpoint/$id'));
  
    if (response.statusCode != 200) {
      // Jika respons bukan 200 (OK), alihkan ke Exception
      throw Exception('Failed to delete poli');
    }
  }
}