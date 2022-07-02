import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:object_detection/ui/question_view_extend.dart';

class QuestionView extends StatefulWidget {
  final String resultClassification;
  const QuestionView({Key key, this.resultClassification}) : super(key: key);

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
    2.0,
    2.0,
    2.0,
    2.0,
    2.0,
    2.0,
    2.0,
    2.0
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String eyeOpacity = widget.resultClassification;
    if(eyeOpacity == "Normal")
      cfUser[6] = 0.0;
    else
      cfUser[6] = 1.0;

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
                  colors: <Color>[Colors.blue, Colors.lightGreen])),
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
                  "Apakah anda kesulitan melihat saat Malam hari?",
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
                  "Apakah anda mengalami penurunan penglihatan terutama di siang hari?",
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
                  "Apakah anda merasa silau ketika mata anda terkena cahaya?",
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
                  "Apakah anda sering mengganti kacamata yang anda pakai?",
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
                  "Apakah anda merasakan nyeri mata?",
                  style: GoogleFonts.openSans(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              buildQuestion(4),
              Divider(
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  "Apakah Lensa Mata anda membengkak?",
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
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(8.0),
                      minimumSize: Size(double.infinity, 24.0)),
                  child: Text(
                    "Lanjut",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    setState(() {
                      log(cfUser.toString());
                      log(selectedAnswer.toString());
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuestionViewExtend(cfUser: cfUser,)));
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
