import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pasien.dart';
import 'constant.dart';

class PasienService {
  static const String endpoint = '$baseUrl/pasien';

  Future<List<Pasien>> getPasien() async {
    final response = await http.get(Uri.parse(endpoint));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['data'] != null) {
        final List<dynamic> pasienList = data['data'];
        return pasienList.map((json) => Pasien.fromJson(json)).toList();
      } else {
        throw Exception('Invalid response format');
      }
    } else {
      throw Exception('Failed to load pasien data');
    }
  }

  Future<void> createPasien(
    String nomorRm,
    String nama,
    String tanggalLahir,
    String nomorTelepon,
    String alamat,
  ) async {
    final response = await http.post(
      Uri.parse(endpoint),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nomor_rm': nomorRm,
        'nama': nama,
        'tanggal_lahir': tanggalLahir,
        'nomor_telepon': nomorTelepon,
        'alamat': alamat,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create pasien');
    }
  }

  Future<void> updatePasien(
    int id,
    String nomorRm,
    String nama,
    String tanggalLahir,
    String nomorTelepon,
    String alamat,
  ) async {
    final response = await http.put(
      Uri.parse('$endpoint/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nomor_rm': nomorRm,
        'nama': nama,
        'tanggal_lahir': tanggalLahir,
        'nomor_telepon': nomorTelepon,
        'alamat': alamat,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update pasien');
    }
  }

  Future<void> deletePasien(int id) async {
    final response = await http.delete(Uri.parse('$endpoint/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete pasien');
    }
  }
}
