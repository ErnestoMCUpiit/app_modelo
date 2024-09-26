import 'package:app_modelo/scan_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CaptureButton extends GetView<scanController>{
const CaptureButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Positioned(
      bottom: 30,
      child: GestureDetector(
        onTap: () => controller.capture(),
        child: Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 5),
            shape: BoxShape.circle
          ),
          child: const Center(
            child: Icon(Icons.camera, size: 60,),
          ),
        ),
      ));
  }
}