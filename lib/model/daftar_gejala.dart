class DaftarGejala {
  final String id, nama;

  DaftarGejala({this.id, this.nama});

  static List<DaftarGejala> daftarGejala(){
    return [
      DaftarGejala(id: 'G001', nama: "Malam hari kesulitan melihat"),
      DaftarGejala(id: 'G002', nama: "Pada siang hari penglihatan menurun "),
      DaftarGejala(id: 'G003', nama: "Mata silau akan cahaya "),
      DaftarGejala(id: 'G004', nama: "Sering ganti kacamata "),
      DaftarGejala(id: 'G005', nama: "Mata nyeri hebat"),
      DaftarGejala(id: 'G006', nama: "Lensa mata membengkak"),
      DaftarGejala(id: 'G007', nama: "Lensa keruh"),
      DaftarGejala(id: 'G008', nama: "Penglihatan buram"),
      DaftarGejala(id: 'G009', nama: "Penglihatan sore lebih nyaman"),
      DaftarGejala(id: 'G010', nama: "Peningkatan rabun jauh"),
      DaftarGejala(id: 'G011', nama: "Pernah cedera pada bola mata"),
      DaftarGejala(id: 'G012', nama: "Memiliki riwayat diabetes"),
      DaftarGejala(id: 'G013', nama: "Memiliki riwayat hipertensi"),
      DaftarGejala(id: 'G014', nama: "Mengalami infeksi pada saluran pernapasan"),
      DaftarGejala(id: 'G015', nama: "Penggunaan steroid jangka panjang"),
      DaftarGejala(id: 'G016', nama: "Minum ramuan yang tidak terdaftar"),
      DaftarGejala(id: 'G017', nama: "Berusia lebih dari 50 tahun"),
      DaftarGejala(id: 'G018', nama: "Usia kejadian satu sampai 10 tahun"),
      DaftarGejala(id: 'G019', nama: "Ada saudara penderita katarak usia dini"),
    ];
  }
}