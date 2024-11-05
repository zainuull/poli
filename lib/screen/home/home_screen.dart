import 'package:flutter/material.dart';
import '../../sidebar.dart';
import 'navigation_title.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Klinik App'),
      ),
      drawer: Sidebar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0, 
          mainAxisSpacing: 10.0,
          children: <Widget>[
            NavigationTile(
              title: 'Poli',
              icon: Icons.local_hospital,
              color: Colors.blue,
              onTap: () => Navigator.pushNamed(context, '/list-poli'),
            ),
            NavigationTile(
              title: 'Pegawai',
              icon: Icons.people,
              color: Colors.green,
              onTap: () => Navigator.pushNamed(context, '/list-pegawai'),
            ),
            NavigationTile(
              title: 'Pasien',
              icon: Icons.person,
              color: Colors.orange,
              onTap: () => Navigator.pushNamed(context, '/list-pasien'),
            ),
          ],
        ),
      ),
    );
  }
}
