class CfPakar {
  final String id, nama;
  final Map<String, num> cf;

  CfPakar({this.id, this.nama, this.cf});

  static List<CfPakar> fetchAll() {
    return [
      CfPakar(id: 'K001', nama: 'Katarak', cf: {
        'G001': -0.6,
        'G002': 0.6,
        'G003': 0.8,
        'G004': 0.6,
        'G005': -0.8,
        'G006': 0.4
      }),
      CfPakar(id: 'K002', nama: 'Katarak Traumatik', cf: {
        'G002': 0.95,
        'G003': -0.1,
        'G007': 1.0,
        'G008': 1.0,
        'G009': 0.8,
        'G011': 1.0
      }),
      CfPakar(id: 'K003', nama: 'Katarak Subkapsularis Posterior', cf: {
        'G002': 0.95,
        'G003': 0.8,
        'G008': 1.0,
        'G009': 0.8,
        'G012': 0.75,
        'G013': 0.3,
        'G014': 0.5,
        'G015': 0.95,
        'G016': 0.3,
      }),
      CfPakar(id: 'K004', nama: 'Katarak Senilis', cf: {
        'G004': 0.4,
        'G007': 1.0,
        'G008': 0.9,
        'G010': 0.7,
        'G017': 0.8,
      }),
      CfPakar(id: 'K005', nama: 'Katarak Juvenile', cf: {
        'G004': 0.7,
        'G007': 1.0,
        'G008': 0.9,
        'G018': 1.0,
        'G019': 0.7,
      })
    ];
  }
}
