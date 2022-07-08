import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:object_detection/ui/question_view.dart';
import 'package:tflite/tflite.dart';


class testImageConvert extends StatefulWidget {
  final String iris;

  const testImageConvert({Key key, this.iris}) : super(key: key);

  @override
  _testImageConvertState createState() => _testImageConvertState();
}

class _testImageConvertState extends State<testImageConvert> {
  String imagePath;
  bool _loading = false;
  List<dynamic> _outputs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    imagePath = widget.iris;
    _loading = true;

    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });

    classifyImage(imagePath);
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
  }

  classifyImage(String imagePath) async {
    var output = await Tflite.runModelOnImage(
      path: imagePath,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _loading = false;
      //Declare List _outputs in the class which will be used to show the classified classs name and confidence
      _outputs = output;
      log(_outputs[0]["label"]);
      log(_outputs.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading
          ? Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : Container(
              color: Color(0xFF00D092),
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              child: Card(
                clipBehavior: Clip.antiAlias,
                color: Color(0xFFEFF5F3),
                margin: EdgeInsets.all(20),
                elevation: 8,
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.white)),
                child: Container(
                  height: 100,
                  color: Colors.white,
                  child: Row(
                    children: [
                      Center(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Expanded(
                            child: imagePath == null
                                ? Container()
                                : Image.file(File(imagePath)),
                            flex: 2,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Column(
                            children: [
                              Expanded(
                                flex: 5,
                                child: ListTile(
                                  title: Text(
                                      "${_outputs[0]["label"]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                      color: _outputs[0]["label"] == "Keruh" ? Colors.red : Colors.lightGreen
                                    ),
                                  ),
                                  subtitle:
                                      Text(
                                          "${_outputs[0]["confidence"] * 100}%",
                                        style: TextStyle(
                                          color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18
                                        ),
                                      ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    FlatButton(
                                      onPressed: () {
                                        // Perform some action
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    QuestionView(
                                                      resultClassification:
                                                          _outputs[0]["label"], imagePath: imagePath,
                                                    )));
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(12.0),
                                        child: const Text(
                                          "Lanjut",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              color: Colors.white),
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          color: Color(0xFF00D092),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        flex: 8,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
//
// import 'dart:io';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class testImageConvert extends StatefulWidget {
//   final String iris;
//   const testImageConvert({Key key, this.iris}) : super(key: key);
//
//   @override
//   _testImageConvertState createState() => _testImageConvertState();
// }
//
// class _testImageConvertState extends State<testImageConvert> {
//   String imagePath;
//   @override
//   void initState() {
//     // TODO: implement initState
//     imagePath = widget.iris;
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         child: ClipRRect(
//             child: Image.file(File(imagePath),
//               scale: 0.1,))
//     );
//   }
// }
