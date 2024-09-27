import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Gallery extends StatefulWidget {
  const Gallery({ Key? key }) : super(key: key);

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
              flex: 75,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 700,
                color: Colors.green,
              ),
            ),
            Expanded(
              flex: 25,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: const Color.fromARGB(255, 35, 47, 58),
                child: Text("asdasdsa"),
              ),
            )
          ],),
      ),
    );
  }
}