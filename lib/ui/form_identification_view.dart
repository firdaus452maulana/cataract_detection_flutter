import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:object_detection/ui/question_view.dart';

class FormIdentificationView extends StatefulWidget {
  const FormIdentificationView({Key key}) : super(key: key);

  @override
  _FormIdentificationViewState createState() => _FormIdentificationViewState();
}

class _FormIdentificationViewState extends State<FormIdentificationView> {
  TextEditingController _nameInputController, _umurInputController;

  String nameInput;
  String umurInput;
  String kelaminInput;

  /// Scaffold Key
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameInputController = TextEditingController();
    _umurInputController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Identity Form', style: GoogleFonts.openSans()),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            /// Nama Lengkap
            Text(
              "Nama",
              style: GoogleFonts.openSans(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            TextFormField(
              cursorColor: Colors.black,
              style: GoogleFonts.openSans(fontSize: 12),
              keyboardType: TextInputType.text,
              controller: _nameInputController,
              decoration: new InputDecoration(
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide(
                          color: Color(0xFF000000).withOpacity(0.15))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide(color: Color(0xFF031F4B))),
                  filled: false,
                  contentPadding: EdgeInsets.only(left: 24.0, right: 24.0),
                  hintStyle: GoogleFonts.openSans(
                      fontSize: 12, color: Color(0xFF000000).withOpacity(0.15)),
                  hintText: "Nama Lengkap",
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide(color: Colors.red)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide(color: Colors.red, width: 1)),
                  errorStyle: GoogleFonts.openSans(fontSize: 10)),
              obscureText: false,
              validator: (value) {
                if (value.isEmpty) {
                  return "Field is required";
                }
                return null;
              },
            ),

            SizedBox(
              height: 16,
            ),

            /// Umur
            Text(
              "Umur",
              style: GoogleFonts.openSans(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            TextFormField(
              cursorColor: Colors.black,
              style: GoogleFonts.openSans(fontSize: 12),
              keyboardType: TextInputType.text,
              controller: _umurInputController,
              decoration: new InputDecoration(
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide(
                          color: Color(0xFF000000).withOpacity(0.15))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide(color: Color(0xFF031F4B))),
                  filled: false,
                  contentPadding: EdgeInsets.only(left: 24.0, right: 24.0),
                  hintStyle: GoogleFonts.openSans(
                      fontSize: 12, color: Color(0xFF000000).withOpacity(0.15)),
                  hintText: "Umur",
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide(color: Colors.red)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide(color: Colors.red, width: 1)),
                  errorStyle: GoogleFonts.openSans(fontSize: 10)),
              obscureText: false,
              validator: (value) {
                if (value.isEmpty) {
                  return "Field is required";
                }
                return null;
              },
            ),

            SizedBox(
              height: 16,
            ),

            RaisedButton(
              child: Text(
                'Lanjut',
                style: GoogleFonts.openSans(),
              ),
              onPressed: (){
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => QuestionView()));
              },
              color: Colors.lightGreen,
              textColor: Colors.white,
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
