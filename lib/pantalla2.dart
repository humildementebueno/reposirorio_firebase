//@dart=2.9
import 'package:registro/menu_lateral.dart';
import 'package:registro/pantalla1.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Pantalla2 extends StatefulWidget {
  @override
  _Pantalla2State createState() => _Pantalla2State();
}

class _Pantalla2State extends State<Pantalla2> {
  TextEditingController controllernomveri = TextEditingController();
  TextEditingController controllernombre = TextEditingController();
  TextEditingController controllerprecio = TextEditingController();
  TextEditingController controllerdescripcion = TextEditingController();
  String producto_nom, descripcion, verificaNom;
  double precio;
  final Firestore firestore = Firestore.instance;

  void _modificar(String proVeri, String prod, double pre, String desc) async {
    DocumentSnapshot documentSnapshot;
    int contador = 0;
    try {
      for (var i = 0; i < 10; i++) {
        contador = contador + 1;
        documentSnapshot = await firestore
            .collection("cursoFlu")
            .document("producto" + contador.toString())
            .get();
        Map<String, dynamic> dato = documentSnapshot.data;
        print("hola mundoooo");
        print("contador modificar: " + contador.toString());
        String cad = dato['producto'].toString();
        print("cadenaaa : " + cad);
        print("verifacar: " + proVeri);
        if (proVeri == cad) {
          print("existe***********");
          firestore
              .collection("cursoFlu")
              .document("producto" + contador.toString())
              .updateData({
            'descripcion': desc,
            'precio': pre.toString(),
            'producto': prod,
          });
          print("*****se actualizo*****");
        }
      }
      print("se modifico");
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Modificar"),
      ),
      drawer: MenuLateral(),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        children: [
          Text(
            "Producto a modificar: ",
            style: TextStyle(fontSize: 35, color: Colors.blueGrey[600]),
          ),
          TextField(
            controller: controllernomveri,
            textAlign: TextAlign.start,
            decoration: InputDecoration(hintText: "  nombre del producto"),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Llena los sgtes datos: ",
            style: TextStyle(fontSize: 22, color: Colors.blueGrey[600]),
          ),
          TextField(
            controller: controllernombre,
            textAlign: TextAlign.start,
            decoration:
                InputDecoration(hintText: "  nuevo nombre del producto"),
          ),
          TextField(
            controller: controllerprecio,
            textAlign: TextAlign.start,
            decoration: InputDecoration(hintText: "  nuevo precio"),
          ),
          TextField(
            controller: controllerdescripcion,
            textAlign: TextAlign.start,
            decoration: InputDecoration(hintText: "  nueva descripcion"),
          ),
          RaisedButton(
            child: Text("Realiza Modificacion"),
            onPressed: () {
              setState(() {
                verificaNom = (controllernomveri.text).toString();
                producto_nom = (controllernombre.text).toString();
                precio = (double.parse((controllerprecio.text).toString()));
                //String precio = pre.toString();
                descripcion = (controllerdescripcion.text).toString();
                print(verificaNom);
                print(producto_nom);
                print(precio.toString());
                print(descripcion);
                print("********************");
                _modificar(verificaNom, producto_nom, precio, descripcion);
              });
            },
          )
        ],
      ),
    );
  }
}
