import 'package:app_modelo/ui/gallery.dart';
import 'package:app_modelo/ui/load_screen.dart';
import 'package:app_modelo/ui/selection.dart';
import 'package:app_modelo/camera/camera_screen.dart';
import 'package:app_modelo/global_b.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // home: const CameraScreen(),
      home: Gallery(),
      title: "detección de peligros",
      initialBinding: GlobalBindings(),
    );
}
}



