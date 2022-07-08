class CfPakar {
  final String id, nama;
  final Map<String, num> cf;

  CfPakar({this.id, this.nama, this.cf});

  static List<CfPakar> fetchAll() {
    return [
      CfPakar(id: 'K001', nama: 'Katarak', cf: {
        'G001': 1.0,
        'G002': 1.0,
        'G003': 1.0,
        'G004': 1.0,
        'G005': 1.0,
        'G006': 1.0
      }),
      CfPakar(id: 'K002', nama: 'Katarak Traumatik', cf: {
        'G001': 1.0,
        'G002': 1.0,
        'G003': 1.0,
        'G004': 1.0,
        'G005': 1.0,
        'G006': 1.0,
        'G007': 1.0
      }),
      CfPakar(id: 'K003', nama: 'Katarak Komplikasi', cf: {
        'G001': 1.0,
        'G002': 1.0,
        'G003': 1.0,
        'G004': 1.0,
        'G005': 1.0,
        'G006': 1.0,
        'G008': 1.0,
        'G009': 1.0,
      }),
      CfPakar(id: 'K004', nama: 'Katarak Senilis', cf: {
        'G001': 1.0,
        'G002': 1.0,
        'G003': 1.0,
        'G004': 1.0,
        'G005': 1.0,
        'G006': 1.0,
        'G010': 1.0,
        'G011': 1.0,
      }),
      CfPakar(id: 'K005', nama: 'Katarak Juvenile', cf: {
        'G001': 1.0,
        'G002': 1.0,
        'G003': 1.0,
        'G004': 1.0,
        'G005': 1.0,
        'G006': 1.0,
        'G012': 1.0,
      })
    ];
  }
}
