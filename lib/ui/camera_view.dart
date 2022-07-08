import 'dart:developer';
import 'dart:io';
import 'dart:isolate';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:object_detection/tflite/classifier.dart';
import 'package:object_detection/tflite/recognition.dart';
import 'package:object_detection/tflite/stats.dart';
import 'package:object_detection/ui/camera_view_singleton.dart';
import 'package:object_detection/ui/test_image_convert.dart';
import 'package:object_detection/utils/image_utils.dart';
import 'package:object_detection/utils/isolate_utils.dart';
import 'package:image/image.dart' as imglib;

import '../main.dart';

/// [CameraView] sends each frame for inference
class CameraView extends StatefulWidget {
  /// Callback to pass results after inference to [HomeView]
  final Function(List<Recognition> recognitions) resultsCallback;

  /// Callback to inference stats to [HomeView]
  final Function(Stats stats) statsCallback;

  /// Callback to inference cameraImage to [HomeView]
  final Function(CameraImage cameraImage) cameraImageCallback;

  /// Constructor
  const CameraView(this.resultsCallback, this.statsCallback, this.cameraImageCallback);
  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> with WidgetsBindingObserver {
  /// List of available cameras
  List<CameraDescription> cameras;

  /// Controller
  CameraController cameraController;

  /// true when inference is ongoing
  bool predicting;

  /// Instance of [Classifier]
  Classifier classifier;

  /// Instance of [IsolateUtils]
  IsolateUtils isolateUtils;

  @override
  void initState() {
    super.initState();
    initStateAsync();
  }

  void initStateAsync() async {
    WidgetsBinding.instance.addObserver(this);

    // Spawn a new isolate
    isolateUtils = IsolateUtils();
    await isolateUtils.start();

    // Camera initialization
    initializeCamera();

    // Create an instance of classifier to load model and labels
    classifier = Classifier();

    // Initially predicting = false
    predicting = false;
  }

  /// Initializes the camera by setting [cameraController]
  void initializeCamera() async {
    cameras = await availableCameras();

    // cameras[0] for rear-camera
    cameraController =
        CameraController(cameras[0], ResolutionPreset.low, enableAudio: false);

    cameraController.initialize().then((_) async {
      // Stream of image passed to [onLatestImageAvailable] callback
      await cameraController.startImageStream(onLatestImageAvailable);

      /// previewSize is size of each image frame captured by controller
      ///
      /// 352x288 on iOS, 240p (320x240) on Android with ResolutionPreset.low
      Size previewSize = cameraController.value.previewSize;

      /// previewSize is size of raw input image to the model
      CameraViewSingleton.inputImageSize = previewSize;

      // the display width of image on screen is
      // same as screenWidth while maintaining the aspectRatio
      Size screenSize = MediaQuery.of(context).size;
      CameraViewSingleton.screenSize = screenSize;
      CameraViewSingleton.ratio = screenSize.width / previewSize.height;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Return empty container while the camera is not initialized
    if (cameraController == null || !cameraController.value.isInitialized) {
      return Container();
    }

    return AspectRatio(
        aspectRatio: cameraController.value.aspectRatio,
        child: CameraPreview(cameraController));
  }

  /// Callback to receive each frame [CameraImage] perform inference on it
  onLatestImageAvailable(CameraImage cameraImage) async {
    if (classifier.interpreter != null && classifier.labels != null) {
      // If previous inference has not completed then return
      if (predicting) {
        return;
      }

      setState(() {
        predicting = true;
      });

      var uiThreadTimeStart = DateTime.now().millisecondsSinceEpoch;

      // Data to be passed to inference isolate
      var isolateData = IsolateData(
          cameraImage, classifier.interpreter.address, classifier.labels);

      // We could have simply used the compute method as well however
      // it would be as in-efficient as we need to continuously passing data
      // to another isolate.

      /// perform inference in separate isolate
      Map<String, dynamic> inferenceResults = await inference(isolateData);

      var uiThreadInferenceElapsedTime =
          DateTime.now().millisecondsSinceEpoch - uiThreadTimeStart;

      // pass cameraImage to HomeView
      widget.cameraImageCallback(cameraImage);

      // pass results to HomeView
      widget.resultsCallback(inferenceResults["recognitions"]);
      // List<Recognition> results = inferenceResults["recognitions"];
      // Size screenSize = MediaQuery.of(context).size;
      // double left,top,width,height;
      // log("Masuk Scan");
      // results.map((e){
      //   // imglib.Image convertedImage = ImageUtils.convertCameraImage(cameraImage);
      //   left = e.renderLocation.left;
      //   top = e.renderLocation.top;
      //   width = e.renderLocation.width;
      //   height = e.renderLocation.height;
      //
      //   imglib.Image convertedImage = ImageUtils.convertCameraImage(cameraImage);
      //   imglib.Image resizedImage = imglib.copyResize(convertedImage,width: (screenSize.width * 0.75).round());
      //   imglib.Image rotatedImage = imglib.copyRotate(resizedImage, 90);
      //
      //   ///crop convertedImage
      //   imglib.Image croppedImage = imglib.copyCrop(rotatedImage, (left/1.75).round(),
      //       (top/1.75).round(), (width/1.75).round(), (height/1.75).round());
      //
      //   String pathFull = MyApp.imgDir;
      //   log(pathFull);
      //   String namafileFull = 'fullCapt.jpg';
      //   pathFull = pathFull + "/" + namafileFull;
      //   var jpgFullFile = imglib.encodeJpg(croppedImage);
      //   new File(pathFull).writeAsBytesSync(jpgFullFile);
      //   Navigator.pushReplacement(
      //       context,
      //       MaterialPageRoute(
      //           builder: (context) => testImageConvert(
      //             iris: pathFull,
      //           )));
      // }).toList();

      // pass stats to HomeView
      widget.statsCallback((inferenceResults["stats"] as Stats)
        ..totalElapsedTime = uiThreadInferenceElapsedTime);

      // set predicting to false to allow new frames
      setState(() {
        predicting = false;
      });
    }
  }

  /// Runs inference in another isolate
  Future<Map<String, dynamic>> inference(IsolateData isolateData) async {
    ReceivePort responsePort = ReceivePort();
    isolateUtils.sendPort
        .send(isolateData..responsePort = responsePort.sendPort);
    var results = await responsePort.first;
    return results;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.paused:
        cameraController.stopImageStream();
        break;
      case AppLifecycleState.resumed:
        if (!cameraController.value.isStreamingImages) {
          await cameraController.startImageStream(onLatestImageAvailable);
        }
        break;
      default:
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    cameraController.dispose();
    super.dispose();
  }
}
