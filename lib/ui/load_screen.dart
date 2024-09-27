import 'package:app_modelo/ui/data.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';


// ignore: camel_case_types
class loadScreen extends StatefulWidget {
  const loadScreen({super.key});

  @override
  State<loadScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<loadScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 20, 44, 92),
      child:  Padding(padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 150),
              child: Text("¿Sabías que?",
                style: TextStyle(
                  color: Color.fromARGB(255, 28, 108, 212),
                  decoration: TextDecoration.none
                ),),
            ),
            LoadingAnimationWidget.fourRotatingDots(color:Color(0xFFF8F8FF),size: 50),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 150, 20, 0),
              child: Text(randomData(),
              textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color.fromARGB(255, 118, 173, 245),
                  decoration: TextDecoration.none,
                  fontSize: 17
                ),),
            ),
          ],
        )),
    );
  }
}