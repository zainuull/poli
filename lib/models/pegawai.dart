class Pegawai {
  final int id;
  final String nip;
  final String nama;
  final String tanggal_lahir;
  final String nomor_telepon;
  final String email;
  final String password;

  Pegawai({
    required this.id,
    required this.nip,
    required this.nama,
    required this.tanggal_lahir,
    required this.nomor_telepon,
    required this.email,
    required this.password,
  });

  factory Pegawai.fromJson(Map<String, dynamic> json) {
    return Pegawai(
      id: json['id'],
      nip: json['nip'],
      nama: json['nama'],
      tanggal_lahir: json['tanggal_lahir'],
      nomor_telepon: json['nomor_telepon'],
      email: json['email'],
      password: json['password'],
    );
  }
}
