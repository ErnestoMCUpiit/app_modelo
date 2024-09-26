import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';
import 'package:app_modelo/helper/image_clasification_helper.dart';
import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import "package:image/image.dart" as img;



class scanController extends GetxController{
  
  final RxBool _isInitialized = RxBool(false);
  bool get isInitialized  => _isInitialized.value;
  late final List<String> labels;
  
  late CameraController _cameraController;
  late List<CameraDescription> _cameras;
  late CameraImage _cameraImage;
  Uint8List? capturedImage;
  CameraController get cameraController => _cameraController;

  late ImageClassificationHelper imageClassificationHelper;
  Map<String, double>? classification;
  bool _isProcessing = false;


  RxList<Uint8List?> _imageList = RxList([]);
  List<Uint8List?> get imageList  => _imageList;

  static const labelsPath = 'assets/labelmap.txt';
  

  Future<void> _initCamera() async{
  _cameras = await availableCameras();
  _cameraController = CameraController(_cameras[0], ResolutionPreset.medium,imageFormatGroup: Platform.isIOS
            ? ImageFormatGroup.bgra8888
            : ImageFormatGroup.yuv420);
  _cameraController.initialize().then((_) {


    _isInitialized.value = true;
    //linea clave 
    // _cameraController.startImageStream((image) => _cameraImage = image);
    cameraController.startImageStream(imageAnalysis);


  }).catchError((Object e) {
    if (e is CameraException) {
      switch (e.code) {
        case 'CameraAccessDenied':
          // Handle access errors here.
          break;
        default:
          // Handle other errors here.
          break;
      }
    }
  });
  }
  Future<void> imageAnalysis(CameraImage cameraImage) async {
    // if image is still analyze, skip this frame
    if (_isProcessing) {
      return;
    }
    _isProcessing = true;
    classification =
        await imageClassificationHelper.inferenceCameraFrame(cameraImage);

    classification?.forEach((label, confidence) {
      print('Label: $label, Confidence: $confidence');
    });
    
  }
  @override
  void onInit() {
    _initCamera();
    imageClassificationHelper = ImageClassificationHelper();
    imageClassificationHelper.initHelper();
    // _loadLabels();
    // _initTfLite();
    super.onInit();
  }

  // Future<void> _initTfLite() async{
  //   final options = InterpreterOptions();
  //   final interpreter = await Interpreter.fromAsset('assets/detect.tflite', options: options);
  //   var inputTensor = interpreter.getInputTensors().first;
  //   // Get tensor output shape [1, 1001]
  //   var outputTensor = interpreter.getOutputTensors().first;
  //   print('Interpreter loaded successfully');
  // }
  // Future<void> _loadLabels() async {
  //   final labelTxt = await rootBundle.loadString(labelsPath);
  //   labels = labelTxt.split('\n');
  // }

  void capture() {
    if (!isInitialized) return;
    
    // Convertir la imagen YUV420 a formato RGB y luego a JPEG
    img.Image image = _convertYUV420toImage(_cameraImage);
    List<int> jpegBytes = img.encodeJpg(image); // Codificar la imagen a formato JPEG
    capturedImage = Uint8List?.fromList(jpegBytes); // Guardar la imagen en Uint8List

    _imageList.add(capturedImage);
    _imageList.refresh();
    
    print("Imagen capturada y convertida a JPEG");
  }

  static img.Image _convertYUV420toImage(CameraImage cameraImage) {
    final imageWidth = cameraImage.width;
    final imageHeight = cameraImage.height;

    final yBuffer = cameraImage.planes[0].bytes;
    final uBuffer = cameraImage.planes[1].bytes;
    final vBuffer = cameraImage.planes[2].bytes;

    final int yRowStride = cameraImage.planes[0].bytesPerRow;
    final int yPixelStride = cameraImage.planes[0].bytesPerPixel!;

    final int uvRowStride = cameraImage.planes[1].bytesPerRow;
    final int uvPixelStride = cameraImage.planes[1].bytesPerPixel!;

    final image = img.Image(width: imageWidth, height: imageHeight);

    for (int h = 0; h < imageHeight; h++) {
      int uvh = (h / 2).floor();

      for (int w = 0; w < imageWidth; w++) {
        int uvw = (w / 2).floor();

        final yIndex = (h * yRowStride) + (w * yPixelStride);

        // Y plane should have positive values belonging to [0...255]
        final int y = yBuffer[yIndex];

        // U/V Values are subsampled i.e. each pixel in U/V chanel in a
        // YUV_420 image act as chroma value for 4 neighbouring pixels
        final int uvIndex = (uvh * uvRowStride) + (uvw * uvPixelStride);

        // U/V values ideally fall under [-0.5, 0.5] range. To fit them into
        // [0, 255] range they are scaled up and centered to 128.
        // Operation below brings U/V values to [-128, 127].
        final int u = uBuffer[uvIndex];
        final int v = vBuffer[uvIndex];

        // Compute RGB values per formula above.
        int r = (y + v * 1436 / 1024 - 179).round();
        int g = (y - u * 46549 / 131072 + 44 - v * 93604 / 131072 + 91).round();
        int b = (y + u * 1814 / 1024 - 227).round();

        r = r.clamp(0, 255);
        g = g.clamp(0, 255);
        b = b.clamp(0, 255);

        image.setPixelRgb(w, h, r, g, b);
      }
    }

    return image;
  }
  
  int _clamp(int val) {
    return val < 0 ? 0 : (val > 255 ? 255 : val);
  }
}