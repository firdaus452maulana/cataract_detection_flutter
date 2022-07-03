import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:object_detection/model/cf_pakar.dart';

class ResultView extends StatefulWidget {
  final List<double> cfUser;

  const ResultView({Key key, this.cfUser}) : super(key: key);

  @override
  _ResultViewState createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
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
    'G012',
    'G013',
    'G014',
    'G015',
    'G016',
    'G017',
    'G018',
    'G019'
  ];
  List<double> cfUser = [];
  Map<String, double> cfValueUser;
  List<cfPakar> cfValuePakar;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cfUser = widget.cfUser;
    cfValueUser = Map.fromIterables(idGejala, widget.cfUser);
    cfValuePakar = cfPakar.fetchAll();
    log(calculateKatarak().toString());
    log(calculateKatarakTraumatik().toString());
    log(calculateKatarakSubkapsularisPosterior().toString());
    log(calculateKatarakSenilis().toString());
    log(calculateKatarakJuvenile().toString());
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
                  colors: <Color>[Colors.blue, Colors.lightGreen])),
        ),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[]),
      ),
    );
  }

  num calculateKatarak() {
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
    return cfGabungan * 100;
  }

  num calculateKatarakTraumatik() {
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
    return cfGabungan * 100;
  }

  num calculateKatarakSubkapsularisPosterior() {
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
    return cfGabungan * 100;
  }

  num calculateKatarakSenilis() {
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
    return cfGabungan * 100;
  }

  num calculateKatarakJuvenile() {
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
    return cfGabungan * 100;
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