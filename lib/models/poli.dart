class Poli {
  final int id; 
  final String poli; 
  final String createdAt; // Waktu data dibuat
  final String updatedAt; // Waktu data diperbarui

Poli(
      {required this.id,
      required this.poli,
      required this.createdAt,
      required this.updatedAt});

factory Poli.fromJson(Map<String, dynamic> json) {
  return Poli(
    id: json['id'],
    poli: json['poli'],
    createdAt: json['created_at'],
    updatedAt: json['updated_at'],
    );
  }
}