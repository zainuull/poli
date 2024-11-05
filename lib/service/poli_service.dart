import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/poli.dart';
import 'constant.dart';

class PoliService {
  static const String endpoint = '$baseUrl/poli';

  Future<List<Poli>> getPoli() async {
    final response = await http.get(Uri.parse(endpoint));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> poliList = data['data'];
      return poliList.map((json) => Poli.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> createPoli(String poliName) async {
    final response = await http.post(
      Uri.parse(endpoint),
      headers: {
        'Content-Type': 'application/json'
      },
      body: jsonEncode({'poli': poliName}),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create poli');
    }
  }

  Future<void> updatePoli(int id, String poliName) async {
    final response = await http.put(
      Uri.parse('$endpoint/$id'),
      headers: {
        'Content-Type': 'application/json'
      },
      body: jsonEncode({'poli': poliName}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update poli');
    }
  }

  Future<void> deletePoli(int id) async {
    final response = await http.delete(Uri.parse('$endpoint/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete poli');
    }
  }
}
