
// ini yang dicoba
class ProdukModel {
  final int id;
  final String kode_produk;
  final String nama_produk;
  final int harga;
  
  ProdukModel({
    required this.id,
    required this.kode_produk,
    required this.nama_produk,
    required this.harga,
  });

  factory ProdukModel.fromJson(Map<String, dynamic> json) {
    // Add null checks and default values if necessary
    return ProdukModel(
      id: json['id'] ?? 0, // Default to 0 if id is not present
      kode_produk: json['kode_produk'] ?? '', // Default to empty string if name is not present
      nama_produk: json['nama_produk'] ?? '', // Default to empty string if name is not present
      harga: json['harga'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'kode_produk': kode_produk,
        'nama_produk': nama_produk,
        'harga': harga,
  };
}