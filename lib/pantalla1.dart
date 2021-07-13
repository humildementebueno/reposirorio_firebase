//@dart=2.9

import 'package:registro/menu_lateral.dart';
import 'package:registro/pantalla2.dart';
import 'package:flutter/material.dart';
import 'package:registro/productos.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Pantalla1 extends StatefulWidget {
  @override
  _Pantalla1State createState() => _Pantalla1State();
}

class _Pantalla1State extends State<Pantalla1> {
  TextEditingController controllernombre = TextEditingController();
  TextEditingController controllerprecio = TextEditingController();
  TextEditingController controllerdescripcion = TextEditingController();
  String producto_nom, descripcion;
  double precio;
  List<Productos> listaProducto;
  int contador = 0;
  final Firestore firestore = Firestore.instance;

  void _guardar(String producto, double precio, String desc) async {
    DocumentSnapshot documentSnapshot;
    try {
      if (contador == 0) {
        contador = 1;
        await firestore
            .collection("cursoFlu")
            .document("producto" + contador.toString())
            .setData({
          'producto': producto,
          'precio': precio.toString(),
          'descripcion': desc,
        });
      } else {
        contador = contador + 1;
        await firestore
            .collection("cursoFlu")
            .document("producto" + contador.toString())
            .setData({
          'producto': producto,
          'precio': precio.toString(),
          'descripcion': desc,
        });
      }
      print("***********se guardo**************");
      print("contador: " + contador.toString());
      documentSnapshot =
          await firestore.collection("cursoFlu").document("producto").get();
      //Map<String, dynamic> dato = documentSnapshot.data;
      Map<String, dynamic> dato = documentSnapshot.data;
      //print(dato['producto']);
      //print(dato['precio']);
      //print(dato.length);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Insertar"),
      ),
      /*menu de la izquierda*/ drawer: MenuLateral(),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        children: [
          TextField(
            controller: controllernombre,
            textAlign: TextAlign.start,
            decoration: InputDecoration(hintText: "  producto"),
          ),
          TextField(
            controller: controllerprecio,
            textAlign: TextAlign.start,
            decoration: InputDecoration(hintText: "  precio"),
          ),
          TextField(
            controller: controllerdescripcion,
            textAlign: TextAlign.start,
            decoration: InputDecoration(hintText: "  descripcion"),
          ),
          RaisedButton(
            child: Text("Guardar"),
            onPressed: () {
              setState(() {
                producto_nom = (controllernombre.text).toString();
                precio = (double.parse((controllerprecio.text).toString()));
                //String precio = pre.toString();
                descripcion = (controllerdescripcion.text).toString();

                _guardar(producto_nom, precio, descripcion);
              });
            },
          )
        ],
      ),
    );
  }
}
