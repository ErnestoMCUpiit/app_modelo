import 'package:flutter/material.dart';

class Selection extends StatefulWidget {
  const Selection({ Key? key }) : super(key: key);

  @override
  _SelectionState createState() => _SelectionState();
}

class _SelectionState extends State<Selection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF8F8FF),
      child: Padding(padding: EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(onPressed: (){}, 
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255,83, 148, 223),
              fixedSize: Size.fromWidth(250),
              padding: const EdgeInsets.all(15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // Borde redondeado de 20 px
                // side: const BorderSide(color: Color.fromARGB(255, 26, 27, 27), width: 2), // Borde con color y ancho
              ),
            ),
            icon: const Icon(Icons.photo_camera_rounded, size: 40,color: Color.fromARGB(255,  20, 44, 92),),
            label: const Text("Modo captura",
              style: TextStyle(
                fontSize: 27,
                color : Color.fromARGB(255, 35, 47, 58)
              ),
          ),),),
          const SizedBox(height: 50,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(onPressed: (){}, 
            
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255,83, 148, 223),
              fixedSize: Size.fromWidth(250),
              padding: const EdgeInsets.all(15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // Borde redondeado de 20 px
                // side: const BorderSide(color: Color.fromARGB(255, 26, 27, 27), width: 2), // Borde con color y ancho
              ),
            ),
            icon: const Icon(Icons.camera, size: 40, color: Color.fromARGB(255,  20, 44, 92),),
            label: const Text("Modo centinela",
            style: TextStyle(
                fontSize: 27,
                color : Color.fromARGB(255, 35, 47, 58)
              ),),
          ))
        ],
        ),
      ),
      
    );
  }
}