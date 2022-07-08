import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:object_detection/model/cf_pakar.dart';
import 'package:object_detection/model/daftar_gejala.dart';

class ResultView extends StatefulWidget {
  final List<double> cfUser;
  final String imagePath;

  const ResultView({Key key, this.cfUser, this.imagePath}) : super(key: key);

  @override
  _ResultViewState createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  String imagePath;
  List<String> idGejala = [
    'G001',
    'G002',
    'G003',
    'G004',
    'G005',
    'G006',
    'G007',
    'G008',
    'G009',
    'G010',
    'G011',
    'G012'
  ];
  List<double> cfUser = [];
  List<String> gejalaUser = [];
  Map<String, double> cfValueUser;
  Map<String, num> cfValueResult = Map();
  List<CfPakar> cfValuePakar;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cfUser = widget.cfUser;
    cfValueUser = Map.fromIterables(idGejala, widget.cfUser);
    cfValuePakar = CfPakar.fetchAll();
    gejalaUser = getGejala();
    imagePath = widget.imagePath;
    log(imagePath);
    log(gejalaUser.toString());
    calculateKatarak();
    calculateKatarakTraumatik();
    calculateKatarakSubkapsularisPosterior();
    calculateKatarakSenilis();
    calculateKatarakJuvenile();
    log(cfValueResult.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Hasil Perhitungan'),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[Color(0xFF00D092), Color(0xFF40DAAC)])),
          ),
        ),
        body: Center(
          child: Container(
              child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              children: <Widget>[
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Container(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                cfValuePakar[0].nama,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                "${cfValueResult[cfValuePakar[0].nama].toStringAsFixed(2)}%",
                                style: TextStyle(
                                    fontSize: 28.0,
                                    fontWeight: FontWeight.bold
                                ),
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.red,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          child: Image.file(File(imagePath)),
                            decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.red,
                        )),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Flexible(
                  flex: 4,
                  fit: FlexFit.tight,
                  child: Container(
                    width: 380,
                    height: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue), //BoxDecoration
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        flex: 5,
                        fit: FlexFit.tight,
                        child: Container(
                          width: 180,
                          height: 300,
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                cfValuePakar[1].nama,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                "${cfValueResult[cfValuePakar[1].nama].toStringAsFixed(2)}%",
                                style: TextStyle(
                                    fontSize: 28.0,
                                    fontWeight: FontWeight.bold
                                ),
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.cyan,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        flex: 5,
                        fit: FlexFit.tight,
                        child: Container(
                            width: 180,
                            height: 300,
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  cfValuePakar[2].nama,
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(
                                  "${cfValueResult[cfValuePakar[2].nama].toStringAsFixed(2)}%",
                                  style: TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold
                                  ),
                                )
                              ],
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.cyan,
                            )),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        flex: 5,
                        fit: FlexFit.tight,
                        child: Container(
                          width: 180,
                          height: 300,
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                cfValuePakar[3].nama,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                "${cfValueResult[cfValuePakar[3].nama].toStringAsFixed(2)}%",
                                style: TextStyle(
                                    fontSize: 28.0,
                                    fontWeight: FontWeight.bold
                                ),
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.cyan,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        flex: 5,
                        fit: FlexFit.tight,
                        child: Container(
                            width: 180,
                            height: 300,
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  cfValuePakar[4].nama,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(
                                  "${cfValueResult[cfValuePakar[4].nama].toStringAsFixed(2)}%",
                                  style: TextStyle(
                                      fontSize: 28.0,
                                      fontWeight: FontWeight.bold
                                  ),
                                )
                              ],
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.cyan,
                            )),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
          )),
        ));
  }

  List<String> getGejala() {
    List<DaftarGejala> daftarGejala = DaftarGejala.daftarGejala();
    Map<String, String> daftarGejalaMap = {};
    daftarGejala.forEach((element) {
      daftarGejalaMap[element.id] = element.nama;
    });
    List<String> result = [];
    cfValueUser.entries.forEach((entry) {
      if (entry.value > 0) {
        result.add(daftarGejalaMap[entry.key]);
      }
    });
    return result;
  }

  calculateKatarak() {
    List<num> cf = [];
    cf.add(cfValuePakar[0].cf['G001'] * cfValueUser['G001']);
    cf.add(cfValuePakar[0].cf['G002'] * cfValueUser['G002']);
    cf.add(cfValuePakar[0].cf['G003'] * cfValueUser['G003']);
    cf.add(cfValuePakar[0].cf['G004'] * cfValueUser['G004']);
    cf.add(cfValuePakar[0].cf['G005'] * cfValueUser['G005']);
    cf.add(cfValuePakar[0].cf['G006'] * cfValueUser['G006']);
    num cfGabungan = cf.first;
    for (int i = 1; i < cf.length; i++) {
      if ((cfGabungan > 0) && (cf[i] > 0)) {
        cfGabungan = _hitungCfPositif(cfGabungan, cf[i]);
      } else if ((cfGabungan < 0) && (cf[i] < 0)) {
        cfGabungan = _hitungCfNgeatif(cfGabungan, cf[i]);
      } else {
        cfGabungan = _hitungCfBeda(cfGabungan, cf[i]);
      }
    }
    cfValueResult[cfValuePakar[0].nama] = cfGabungan * 100;
  }

  calculateKatarakTraumatik() {
    List<num> cf = [];
    cf.add(cfValuePakar[1].cf['G002'] * cfValueUser['G002']);
    cf.add(cfValuePakar[1].cf['G003'] * cfValueUser['G003']);
    cf.add(cfValuePakar[1].cf['G007'] * cfValueUser['G007']);
    cf.add(cfValuePakar[1].cf['G008'] * cfValueUser['G008']);
    cf.add(cfValuePakar[1].cf['G009'] * cfValueUser['G009']);
    cf.add(cfValuePakar[1].cf['G011'] * cfValueUser['G011']);
    num cfGabungan = cf.first;
    for (int i = 1; i < cf.length; i++) {
      if ((cfGabungan > 0) && (cf[i] > 0)) {
        cfGabungan = _hitungCfPositif(cfGabungan, cf[i]);
      } else if ((cfGabungan < 0) && (cf[i] < 0)) {
        cfGabungan = _hitungCfNgeatif(cfGabungan, cf[i]);
      } else {
        cfGabungan = _hitungCfBeda(cfGabungan, cf[i]);
      }
    }
    cfValueResult[cfValuePakar[1].nama] = cfGabungan * 100;
  }

  calculateKatarakSubkapsularisPosterior() {
    List<num> cf = [];
    cf.add(cfValuePakar[2].cf['G002'] * cfValueUser['G002']);
    cf.add(cfValuePakar[2].cf['G003'] * cfValueUser['G003']);
    cf.add(cfValuePakar[2].cf['G008'] * cfValueUser['G008']);
    cf.add(cfValuePakar[2].cf['G009'] * cfValueUser['G009']);
    cf.add(cfValuePakar[2].cf['G012'] * cfValueUser['G012']);
    cf.add(cfValuePakar[2].cf['G013'] * cfValueUser['G013']);
    cf.add(cfValuePakar[2].cf['G014'] * cfValueUser['G014']);
    cf.add(cfValuePakar[2].cf['G015'] * cfValueUser['G015']);
    cf.add(cfValuePakar[2].cf['G016'] * cfValueUser['G016']);
    num cfGabungan = cf.first;
    for (int i = 1; i < cf.length; i++) {
      if ((cfGabungan > 0) && (cf[i] > 0)) {
        cfGabungan = _hitungCfPositif(cfGabungan, cf[i]);
      } else if ((cfGabungan < 0) && (cf[i] < 0)) {
        cfGabungan = _hitungCfNgeatif(cfGabungan, cf[i]);
      } else {
        cfGabungan = _hitungCfBeda(cfGabungan, cf[i]);
      }
    }
    cfValueResult[cfValuePakar[2].nama] = cfGabungan * 100;
  }

  calculateKatarakSenilis() {
    List<num> cf = [];
    cf.add(cfValuePakar[3].cf['G004'] * cfValueUser['G004']);
    cf.add(cfValuePakar[3].cf['G007'] * cfValueUser['G007']);
    cf.add(cfValuePakar[3].cf['G008'] * cfValueUser['G008']);
    cf.add(cfValuePakar[3].cf['G010'] * cfValueUser['G010']);
    cf.add(cfValuePakar[3].cf['G017'] * cfValueUser['G017']);
    num cfGabungan = cf.first;
    for (int i = 1; i < cf.length; i++) {
      if ((cfGabungan > 0) && (cf[i] > 0)) {
        cfGabungan = _hitungCfPositif(cfGabungan, cf[i]);
      } else if ((cfGabungan < 0) && (cf[i] < 0)) {
        cfGabungan = _hitungCfNgeatif(cfGabungan, cf[i]);
      } else {
        cfGabungan = _hitungCfBeda(cfGabungan, cf[i]);
      }
    }
    cfValueResult[cfValuePakar[3].nama] = cfGabungan * 100;
  }

  calculateKatarakJuvenile() {
    List<num> cf = [];
    cf.add(cfValuePakar[4].cf['G004'] * cfValueUser['G004']);
    cf.add(cfValuePakar[4].cf['G007'] * cfValueUser['G007']);
    cf.add(cfValuePakar[4].cf['G008'] * cfValueUser['G008']);
    cf.add(cfValuePakar[4].cf['G018'] * cfValueUser['G018']);
    cf.add(cfValuePakar[4].cf['G019'] * cfValueUser['G019']);
    num cfGabungan = cf.first;
    for (int i = 1; i < cf.length; i++) {
      if ((cfGabungan > 0) && (cf[i] > 0)) {
        cfGabungan = _hitungCfPositif(cfGabungan, cf[i]);
      } else if ((cfGabungan < 0) && (cf[i] < 0)) {
        cfGabungan = _hitungCfNgeatif(cfGabungan, cf[i]);
      } else {
        cfGabungan = _hitungCfBeda(cfGabungan, cf[i]);
      }
    }
    cfValueResult[cfValuePakar[4].nama] = cfGabungan * 100;
  }

  num _hitungCfPositif(num cfLama, num cfBaru) {
    num result = cfLama + (cfBaru * (1 - cfLama));
    return result;
  }

  num _hitungCfNgeatif(num cfLama, num cfBaru) {
    num result = cfLama + (cfBaru * (1 + cfLama));
    return result;
  }

  num _hitungCfBeda(num cfLama, num cfBaru) {
    num result = cfLama + cfBaru / (1 - math.min(cfLama, cfBaru));
    return result;
  }
}
