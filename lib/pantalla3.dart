//@dart=2.9
import 'package:flutter/material.dart';
import 'package:registro/menu_lateral.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Pantalla3 extends StatefulWidget {
  @override
  _Pantalla3State createState() => _Pantalla3State();
}

class _Pantalla3State extends State<Pantalla3> {
  TextEditingController controllernombre = TextEditingController();
  TextEditingController controllerprecio = TextEditingController();
  TextEditingController controllerdescripcion = TextEditingController();
  String producto_nom, descripcion;
  double precio;
  int contador = 0;
  final Firestore firestore = Firestore.instance;

  void _eliminar(String nombreProd) async {
    contador = 0;
    DocumentSnapshot documentSnapshot;
    try {
      // firestore.collection("cursoFlu").document("producto").delete();
      // documentSnapshot =
      //     await firestore.collection("cursoFlu").document("producto2").get();
      // print(documentSnapshot.data);
      for (int i = 0; i < 1000; i++) {
        print("entrooo");
        //print(i);
        contador = contador + 1;
        print(contador);
        documentSnapshot = await firestore
            .collection("cursoFlu")
            .document("producto" + contador.toString())
            .get();

        if (documentSnapshot.data == null) {
          print("la lista es null: " + contador.toString());
          //break;
        } else {
          Map<String, dynamic> dato = documentSnapshot.data;
          //print(dato['producto']);
          //print(dato['precio']);
          print(dato.length);
          print(nombreProd);
          print("*********");
          if (nombreProd == dato['producto']) {
            firestore
                .collection("cursoFlu")
                .document("producto" + contador.toString())
                .delete();
            print("*****se eliminoo*****");
            break;
          } else {
            print("no existe el producto");
          }
        }
      }

      //print("***********se guardo**************");
    } catch (e) {}
  }

  //TextEditingController controllernombre = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Eliminar"),
      ),
      drawer: MenuLateral(),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        children: [
          Text(
            "Producto a eliminar: ",
            style: TextStyle(fontSize: 35, color: Colors.blueGrey[600]),
          ),
          TextField(
            controller: controllernombre,
            textAlign: TextAlign.start,
            decoration: InputDecoration(hintText: " nombre del producto"),
          ),
          RaisedButton(
              child: Text("Eliminar"),
              onPressed: () {
                setState(() {
                  producto_nom = (controllernombre.text).toString();
                  _eliminar(producto_nom);
                  print(producto_nom);
                });
              }),
        ],
      ),
    );
  }
}
