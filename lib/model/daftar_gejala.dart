class DaftarGejala {
  final String id, nama;

  DaftarGejala({this.id, this.nama});

  static List<DaftarGejala> daftarGejala(){
    return [
      DaftarGejala(id: 'G001', nama: "Pada siang hari penglihatan menurun"),
      DaftarGejala(id: 'G002', nama: "Mata silau akan cahaya"),
      DaftarGejala(id: 'G003', nama: "Sering ganti kacamata / Peningkatan rabun jauh"),
      DaftarGejala(id: 'G004', nama: "Penglihatan Berkabut"),
      DaftarGejala(id: 'G005', nama: "Lensa keruh"),
      DaftarGejala(id: 'G006', nama: "Penglihatan sore lebih nyaman"),
      DaftarGejala(id: 'G007', nama: "Pernah cedera pada bola mata"),
      DaftarGejala(id: 'G008', nama: "Memiliki riwayat diabetes"),
      DaftarGejala(id: 'G009', nama: "Penggunaan steroid jangka panjang / Meminum ramuan yang tidak terdaftar"),
      DaftarGejala(id: 'G010', nama: "Berusia lebih dari 50 tahun"),
      DaftarGejala(id: 'G011', nama: "Usia kejadian satu sampai 10 tahun"),
      DaftarGejala(id: 'G012', nama: "Berusia kurang dari 50 tahun"),
    ];
  }
}