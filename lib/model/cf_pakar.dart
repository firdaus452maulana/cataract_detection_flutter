class cfPakar {
  final String id, nama;
  final Map<String, num> cf;

  cfPakar({this.id, this.nama, this.cf});

  static List<cfPakar> fetchAll() {
    return [
      cfPakar(id: 'K001', nama: 'Katarak', cf: {
        'G001': -0.6,
        'G002': 0.6,
        'G003': 0.8,
        'G004': 0.6,
        'G005': -0.8,
        'G006': 0.4
      }),
      cfPakar(id: 'K002', nama: 'Katarak Traumatik', cf: {
        'G002': 0.95,
        'G003': -0.1,
        'G007': 1.0,
        'G008': 1.0,
        'G009': 0.8,
        'G011': 1.0
      }),
      cfPakar(id: 'K003', nama: 'Katarak Subkapsularis Posterior', cf: {
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
      cfPakar(id: 'K004', nama: 'Katarak Senilis', cf: {
        'G004': 0.4,
        'G007': 1.0,
        'G008': 0.9,
        'G010': 0.7,
        'G017': 0.8,
      }),
      cfPakar(id: 'K005', nama: 'Katarak Juvenile', cf: {
        'G004': 0.7,
        'G007': 1.0,
        'G008': 0.9,
        'G018': 1.0,
        'G019': 0.7,
      })
    ];
  }
}
