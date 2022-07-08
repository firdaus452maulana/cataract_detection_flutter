import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:object_detection/ui/question_view_extend.dart';
import 'package:object_detection/ui/result_view.dart';

class QuestionView extends StatefulWidget {
  final String resultClassification;
  final String imagePath;

  const QuestionView({Key key, this.resultClassification, this.imagePath})
      : super(key: key);

  @override
  _QuestionViewState createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
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
    '0'
  ];
  List<double> cfUser = [
    2.0,
    2.0,
    2.0,
    2.0,
    2.0,
    2.0,
    2.0,
    2.0,
    2.0,
    2.0,
    2.0,
    2.0
  ];
  String imagePath;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String eyeOpacity = widget.resultClassification;
    imagePath = widget.imagePath;
    log("imagePath");
    log(imagePath);
    if (eyeOpacity == "Normal")
      cfUser[4] = 0.0;
    else
      cfUser[4] = 1.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gejala'),
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
                  "Apakah anda mengalami penurunan penglihatan terutama di siang hari?",
                  style: GoogleFonts.openSans(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              buildQuestion(0),
              Divider(
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  "Apakah anda merasa silau ketika mata anda terkena cahaya?",
                  style: GoogleFonts.openSans(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              buildQuestion(1),
              Divider(
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  "Apakah anda sering mengganti kacamata yang anda pakai (peningkatan rabun jauh)?",
                  style: GoogleFonts.openSans(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              buildQuestion(2),
              Divider(
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  "Apakah penglihatan anda berkabut?",
                  style: GoogleFonts.openSans(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              buildQuestion(3),
              Divider(
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  "Apakah ketika sore penglihatan anda lebih nyaman",
                  style: GoogleFonts.openSans(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              buildQuestion(5),
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
              buildQuestion(6),
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
              buildQuestion(7),
              Divider(
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  "Apakah anda menggunakan steroid atau mengonsumsi minuman tak terdaftar dalam jangka panjang?",
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
                  "Apakah anda Berusia lebih dari 50 tahun?",
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
                  "Apakah anda mengalami gangguan penglihatan antara satu sampai 10 tahun?",
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
                  "Apakah anda Berusia kurang dari 50 tahun?",
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
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xFF00D092),
                      padding: EdgeInsets.all(8.0),
                      minimumSize: Size(double.infinity, 24.0)),
                  child: Text(
                    "Lanjut",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    setState(() {
                      bool next = true;
                      log(imagePath);
                      log(cfUser.toString());
                      log(selectedAnswer.toString());
                      for (int i = 0; i < 12; i++) {
                        if (cfUser[i] > 1.0) {
                          next = false;
                          break;
                        }
                      }
                      if (next)
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResultView(
                                    cfUser: cfUser, imagePath: imagePath)));
                      else
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                const Text('Mohon Jawab Seluruh Pertanyaan'),
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
