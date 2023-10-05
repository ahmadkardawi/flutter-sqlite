class Student {
  final int? id;
  final String? judul;
  final String? isi;
  final String? cretedAt;
  final String? updatedAt;
  Student({this.id, this.judul, this.isi, this.cretedAt, this.updatedAt});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'judul': judul,
      'isi': isi,
      'cretedAt': cretedAt,
      'updatedAt': updatedAt
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      judul: map['judul'],
      isi: map['isi'],
      cretedAt: map['cretedAt'],
      updatedAt: map['updatedAt'],
    );
  }
}
