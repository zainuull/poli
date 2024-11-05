import 'package:flutter/material.dart';
import 'screen/home/home_screen.dart';
import 'screen/pasien/pasien_list_screen copy.dart';
import 'screen/pasien/pasien_form_screen.dart';
import 'screen/pegawai/pegawai_list_screen copy.dart';
import 'screen/pegawai/pegawai_form_screen.dart';
import 'screen/poli/poli_list_screen.dart';
import 'screen/poli/poli_form_screen.dart';
import 'models/pasien.dart';
import 'models/pegawai.dart';
import 'models/poli.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Klinik App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/list-pasien': (context) => PasienListScreen(),
        '/add-pasien': (context) => PasienFormScreen(),
        '/edit-pasien': (context) => PasienFormScreen(
          pasien: ModalRoute.of(context)?.settings.arguments as Pasien?,
        ),
        '/list-pegawai': (context) => PegawaiListScreen(),
        '/add-pegawai': (context) => PegawaiFormScreen(),
        '/edit-pegawai': (context) => PegawaiFormScreen(
          pegawai: ModalRoute.of(context)?.settings.arguments as Pegawai?,
        ),
        '/list-poli': (context) => PoliListScreen(),
        '/add-poli': (context) => PoliFormScreen(),
        '/edit-poli': (context) => PoliFormScreen(
          poli: ModalRoute.of(context)?.settings.arguments as Poli?,
        ),
      },
    );
  }
}
