import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createDrawerHeader(),
          _createDrawerItem(
            icon: Icons.home,
            text: 'Home',
            onTap: () => Navigator.pushNamed(context, '/'),
          ),
          _createDrawerItem(
            icon: Icons.local_hospital,
            text: 'Poli',
            onTap: () => Navigator.pushNamed(context, '/list-poli'),
          ),
          _createDrawerItem(
            icon: Icons.people,
            text: 'Pegawai',
            onTap: () => Navigator.pushNamed(
              context,
              '/list-pegawai',
            ),
          ),
          _createDrawerItem(
            icon: Icons.person,
            text: 'Pasien',
            onTap: () => Navigator.pushNamed(
              context,
              '/list-pasien',
            ),
          ),
        ],
      ),
    );
  }

  Widget _createDrawerHeader() {
    return const DrawerHeader(
      decoration: BoxDecoration(
        color: Colors.blue,
      ),
      child: Text(
        'Klinik App',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
      ),
    );
  }

  Widget _createDrawerItem(
    {
    required IconData icon,
    required String text,
    required GestureTapCallback onTap,
  }) 
  {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: onTap,
    );
  }
}
