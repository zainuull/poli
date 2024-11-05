import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pegawai.dart';
import 'constant.dart';

class PegawaiService {
  static const String endpoint = '$baseUrl/pegawai';

  Future<List<Pegawai>> getPegawai() async {
    final response = await http.get(Uri.parse(endpoint));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['data'] != null) {
        final List<dynamic> pegawaiList = data['data']; 
        return pegawaiList.map((json) => Pegawai.fromJson(json)).toList();
      } else {
        throw Exception('Invalid response format');
      }
    } else {
      throw Exception('Failed to load pegawai data');
    }
  }

  Future<void> createPegawai(
    String nip,
    String nama,
    String tanggalLahir,
    String nomorTelepon,
    String email,
    String password
  ) async {
    final response = await http.post(
      Uri.parse(endpoint),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nip': nip,
        'nama': nama,
        'tanggal_lahir': tanggalLahir,
        'nomor_telepon': nomorTelepon,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create pegawai');
    }
  }

  Future<void> updatePegawai(
    int id,
    String nip,
    String nama,
    String tanggalLahir,
    String nomorTelepon,
    String email,
    String password
  ) async {
    final response = await http.put(
      Uri.parse('$endpoint/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nip': nip,
        'nama': nama,
        'tanggal_lahir': tanggalLahir,
        'nomor_telepon': nomorTelepon,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update pegawai');
    }
  }

  Future<void> deletePegawai(int id) async {
    final response = await http.delete(Uri.parse('$endpoint/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete pegawai');
    }
  }
}
