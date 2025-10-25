class Transaction {
  final DateTime tanggal;
  final double jumlah;
  final String keterangan;

  Transaction({
    required this.tanggal,
    required this.jumlah,
    required this.keterangan,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      tanggal: DateTime.parse(json['tanggal']),
      jumlah: (json['jumlah'] as num).toDouble(),
      keterangan: json['keterangan'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tanggal': tanggal.toIso8601String(),
      'jumlah': jumlah,
      'keterangan': keterangan,
    };
  }
}
