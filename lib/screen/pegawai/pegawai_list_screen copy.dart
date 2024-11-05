import 'package:flutter/material.dart';
import '../../models/pegawai.dart';
import '../../service/pegawai_service.dart';
import '../../sidebar.dart';

class PegawaiListScreen extends StatefulWidget {
  const PegawaiListScreen({super.key});

  @override
  _PegawaiListScreenState createState() => _PegawaiListScreenState();
}

class _PegawaiListScreenState extends State<PegawaiListScreen> {
  List<Pegawai> _pegawaiList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPegawaiData();
  }

  Future<void> _loadPegawaiData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      _pegawaiList = await PegawaiService().getPegawai();
    } catch (e) {
      _showErrorDialog(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _deletePegawai(int id) async {
    bool? confirmDelete = await _showDeleteConfirmation();
    if (confirmDelete == true) {
      try {
        await PegawaiService().deletePegawai(id);
        _loadPegawaiData();
      } catch (e) {
        _showErrorDialog(e.toString());
      }
    }
  }

  Future<void> _showErrorDialog(String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool?> _showDeleteConfirmation() async {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Pegawai'),
        content: const Text('Are you sure you want to delete this pegawai?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Pegawai List'),
    ),
    drawer: Sidebar(),
    body: _isLoading
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: _pegawaiList.length,
            itemBuilder: (context, index) {
              final pegawai = _pegawaiList[index];
              return ListTile(
                title: Text(pegawai.nama),
                subtitle: Text(pegawai.nip),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Navigator.pushNamed(context, '/edit-pegawai', arguments: pegawai).then((value) => _loadPegawaiData());
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _deletePegawai(pegawai.id),
                    ),
                  ],
                ),
              );
            },
          ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, '/add-pegawai').then((value) => _loadPegawaiData());
      },
      tooltip: 'Add Pegawai',
      child: Icon(Icons.add),
    ),
  );
}
}