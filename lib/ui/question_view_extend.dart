import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:object_detection/ui/result_view.dart';

class QuestionViewExtend extends StatefulWidget {
  final List<double> cfUser;
  final String imagePath;

  const QuestionViewExtend({Key key, this.cfUser, this.imagePath}) : super(key: key);

  @override
  _QuestionViewExtendState createState() => _QuestionViewExtendState();
}

class _QuestionViewExtendState extends State<QuestionViewExtend> {
  String imagePath;
  static const answer = <String>[
    'Tidak',
    'Mungkin',
    'Kemungkinan Besar',
    'Hampir Pasti',
    'Pasti'
  ];
  List<String> selectedAnswer = [
    '0',
    '0',
    '0',
    '0',
    '0',
    '0',
    '0',
    '0',
    '0',
    '0',
    '0',
    '0',
    '0',
    '0',
    '0',
    '0',
    '0',
    '0',
    '0'
  ];
  List<double> cfUser = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imagePath = widget.imagePath;
    log(imagePath);
    cfUser = widget.cfUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gejala Lanjutan'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xFF00D092), Color(0xFF40DAAC)])),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  "Apakah Penglihatan anda buram?",
                  style: GoogleFonts.openSans(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              buildQuestion(7),
              Divider(
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  "Apakah Penglihatan anda pada saat sore lebih nyaman?",
                  style: GoogleFonts.openSans(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              buildQuestion(8),
              Divider(
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  "Apakah anda mengalami peningkatan pada rabun jauh?",
                  style: GoogleFonts.openSans(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              buildQuestion(9),
              Divider(
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  "Apakah anda pernah mengalami cidera pada bola mata?",
                  style: GoogleFonts.openSans(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              buildQuestion(10),
              Divider(
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  "Apakah anda memiliki riwayat penyakit Diabetes?",
                  style: GoogleFonts.openSans(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              buildQuestion(11),
              Divider(
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  "Apakah anda memiliki riwayat penyakit Hipertensi?",
                  style: GoogleFonts.openSans(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              buildQuestion(12),
              Divider(
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  "Apakah anda mengalami infeksi pada saluran pernapasan?",
                  style: GoogleFonts.openSans(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              buildQuestion(13),
              Divider(
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  "Apakah anda menggunakan steroid dalam jangka panjang?",
                  style: GoogleFonts.openSans(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              buildQuestion(14),
              Divider(
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  "Apakah anda meminum ramuan yang tidak terdaftar?",
                  style: GoogleFonts.openSans(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              buildQuestion(15),
              Divider(
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  "Apakah anda Berusia lebih dari 50 tahun?",
                  style: GoogleFonts.openSans(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              buildQuestion(16),
              Divider(
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  "Apakah anda mengalami rasa sakit tersebut antara satu sampai 10 tahun?",
                  style: GoogleFonts.openSans(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              buildQuestion(17),
              Divider(
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  "Apakah anda memiliki saudara penderita katarak usia dini?",
                  style: GoogleFonts.openSans(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              buildQuestion(18),
              Divider(
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xFF00D092),
                      padding: EdgeInsets.all(8.0),
                      minimumSize: Size(double.infinity, 24.0)),
                  child: Text(
                    "Submit",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    setState(() {
                      bool next = true;
                      log(cfUser.toString());
                      for (int i=7; i<19; i++){
                        if (cfUser[i] > 1.0){
                          next = false;
                          break;
                        }
                      }
                      if (next) {
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResultView(cfUser: cfUser,imagePath: imagePath)));
                      } else
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Mohon Jawab Seluruh Pertanyaan'),
                          ),
                        );
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildQuestion(int index) {
    return Column(
      children: answer.map(
            (value) {
          return RadioListTile(
              activeColor: Color(0xFF00D092),
              value: value,
              groupValue: selectedAnswer[index],
              title: Text(value),
              onChanged: (value) => setState(() {
                this.selectedAnswer[index] = value;
                cfUser[index] = _score(value);
                log("$index, ${cfUser[index].toString()}");
              }));
        },
      ).toList(),
    );
  }
}

double _score(String value) {
  if (value == 'Tidak')
    return 0.0;
  else if (value == 'Mungkin')
    return 0.25;
  else if (value == 'Kemungkinan Besar')
    return 0.5;
  else if (value == 'Hampir Pasti')
    return 0.75;
  else
    return 1.0;
}