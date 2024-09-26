import "package:app_modelo/camera/camera_views.dart";
import "package:app_modelo/camera/capture_button.dart";
import "package:app_modelo/camera/top_image_viewer.dart";
import "package:app_modelo/scan_controller.dart";
import "package:camera/camera.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [ const 
        CameraViewer(),
        CaptureButton(),
        TopImageViewer()
      ],
    );
  }
}