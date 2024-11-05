class Pasien {
  final int id;
  final String nomor_rm;
  final String nama;
  final String tanggal_lahir;
  final String nomor_telepon;
  final String alamat;

  Pasien({
    required this.id,
    required this.nomor_rm,
    required this.nama,
    required this.tanggal_lahir,
    required this.nomor_telepon,
    required this.alamat,
  });

  factory Pasien.fromJson(Map<String, dynamic> json) {
    return Pasien(
      id: json['id'],
      nomor_rm: json['nomor_rm'],
      nama: json['nama'],
      tanggal_lahir: json['tanggal_lahir'],
      nomor_telepon: json['nomor_telepon'],
      alamat: json['alamat'],
    );
  }
}
