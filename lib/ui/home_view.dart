import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:object_detection/tflite/recognition.dart';
import 'package:object_detection/tflite/stats.dart';
import 'package:object_detection/ui/box_widget.dart';
import 'package:object_detection/ui/camera_view_singleton.dart';
import 'package:image/image.dart' as imglib;
import 'package:object_detection/ui/test_image_convert.dart';
import 'package:object_detection/utils/image_utils.dart';

import '../main.dart';
import 'camera_view.dart';

/// [HomeView] stacks [CameraView] and [BoxWidget]s with bottom sheet for stats
class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  /// Results to draw bounding boxes
  List<Recognition> results;

  /// Realtime stats
  Stats stats;

  /// Realtime stats
  CameraImage cameraImage;

  /// Scaffold Key
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          // Camera View
          CameraView(resultsCallback, statsCallback, cameraImageCallback),

          // Bounding boxes
          boundingBoxes(results),

          // Heading
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                'Object Detection Flutter',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrangeAccent.withOpacity(0.6),
                ),
              ),
            ),
          ),

          // Bottom Sheet
          Align(
            alignment: Alignment.bottomCenter,
            child: DraggableScrollableSheet(
              initialChildSize: 0.4,
              minChildSize: 0.1,
              maxChildSize: 0.5,
              builder: (_, ScrollController scrollController) => Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BORDER_RADIUS_BOTTOM_SHEET),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.keyboard_arrow_up,
                            size: 48, color: Colors.orange),
                        (stats != null)
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    StatsRow('Inference time:',
                                        '${stats.inferenceTime} ms'),
                                    StatsRow('Total prediction time:',
                                        '${stats.totalElapsedTime} ms'),
                                    StatsRow('Pre-processing time:',
                                        '${stats.preProcessingTime} ms'),
                                    StatsRow('Frame',
                                        '${CameraViewSingleton.inputImageSize?.width} X ${CameraViewSingleton.inputImageSize?.height}'),
                                  ],
                                ),
                              )
                            : Container()
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: new Visibility(
          visible: results != null ? true : false,
          child: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              _captureAndClassify(results, cameraImage);
            },
          )),
    );
  }

  /// Returns Stack of bounding boxes
  Widget boundingBoxes(List<Recognition> results) {
    if (results == null) {
      return Container();
    }
    return Stack(
      children: results
          .map((e) => BoxWidget(
                result: e,
              ))
          .toList(),
    );
  }

  void _captureAndClassify(List<Recognition> results, CameraImage cameraImage) {
    double left, top, width, height;
    Size screenSize = MediaQuery.of(context).size;
    results.map((e) {

      left = e.renderLocation.left;
      top = e.renderLocation.top;
      width = e.renderLocation.width;
      height = e.renderLocation.height;

      imglib.Image convertedImage = ImageUtils.convertCameraImage(cameraImage);
      imglib.Image resizedImage = imglib.copyResize(convertedImage,width: (screenSize.width * 0.75).round());
      imglib.Image rotatedImage = imglib.copyRotate(resizedImage, 90);
      log("$left");
      log("$top");
      log("$width");
      log("$height");

      ///crop convertedImage
      imglib.Image croppedImage = imglib.copyCrop(rotatedImage, (left/1.75).round(),
          (top/1.75).round(), (width/1.75).round(), (height/1.75).round());

      log("${left.round()}");
      log("${top.round()}");
      log("${width.round()}");
      log("${height.round()}");

      String pathFull = MyApp.imgDir;
      log(pathFull);
      String namafileFull = 'fullCapt.jpg';
      pathFull = pathFull + "/" + namafileFull;
      var jpgFullFile = imglib.encodeJpg(croppedImage);
      new File(pathFull).writeAsBytesSync(jpgFullFile);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => testImageConvert(
                    iris: pathFull,
                  )));
    }).toList();
  }

  /// Callback to get inference results from [CameraView]
  void resultsCallback(List<Recognition> results) {
    setState(() {
      this.results = results;
    });
  }

  /// Callback to get inference stats from [CameraView]
  void statsCallback(Stats stats) {
    setState(() {
      this.stats = stats;
    });
  }

  /// Callback to get inference cameraImage from [CameraView]
  void cameraImageCallback(CameraImage cameraImage) {
    this.cameraImage = cameraImage;
  }

  static const BOTTOM_SHEET_RADIUS = Radius.circular(24.0);
  static const BORDER_RADIUS_BOTTOM_SHEET = BorderRadius.only(
      topLeft: BOTTOM_SHEET_RADIUS, topRight: BOTTOM_SHEET_RADIUS);
}

/// Row for one Stats field
class StatsRow extends StatelessWidget {
  final String left;
  final String right;

  StatsRow(this.left, this.right);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(left), Text(right)],
      ),
    );
  }
}
