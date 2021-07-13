//@dart=2.9

import 'package:flutter/material.dart';
import 'package:registro/menu_lateral.dart';
import 'package:registro/productos.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Principal(),
    );
  }
}

class Principal extends StatefulWidget {
  @override
  _PrincipalState createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  String nombre = "", descripcion = "";
  double precio;
  int contador;
  final Firestore firestore = Firestore.instance;
  List<Productos> listaProducto;
  void initState() {
    listaProducto = new List();
    super.initState();
    //print(listaProducto.length);
    //print("comenzando");
    cargarlist();
  }

  void cargarlist() async {
    contador = 0;
    DocumentSnapshot documentSnapshot;
    try {
      for (int i = 0; i < 10; i++) {
        print("cargandooo");
        //print(i);
        contador = contador + 1;
        print("contador: " + contador.toString());
        documentSnapshot = await firestore
            .collection("cursoFlu")
            .document("producto" + contador.toString())
            .get();
        Map<String, dynamic> dato = documentSnapshot.data;
        if (documentSnapshot.data == null) {
          print("la lista es null: " + contador.toString());
          break;
        } else {
          print(dato['producto'].toString());
          print(dato['descripcion'].toString());
          print(dato['precio'].toString());
          setState(() {
            listaProducto.add(new Productos(
                dato['producto'].toString(),
                dato['descripcion'].toString(),
                double.parse(dato['precio'].toString())));
          });
          print("tamaño de la lista: " + listaProducto.length.toString());
          // print(listaProducto[0].nombre);
        }
        print("********");
        print(listaProducto[i].nombre);
      }
    } catch (e) {}

    //  listaProducto.add(value)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registro de Productos"),
      ),
      drawer: MenuLateral(),
      body: listas(),
    );
  }

  ListView listas() {
    if (listaProducto.length == 0) {
      print(listaProducto.length);
      print("no tiene productos");
      return ListView(
        children: [
          Text(
            "no tiene productos!!.. Inserte uno... :)",
            style: TextStyle(fontSize: 45, color: Colors.red[600]),
          )
        ],
      );
    } else {
      print("lista no vacia");
      print(listaProducto.length);
      return ListView.builder(
          itemCount: listaProducto.length,
          itemBuilder: (contex, index) {
            return ListTile(
              title: Text("Producto: " + listaProducto[index].nombre),
              subtitle: Text("Descripcion " +
                  listaProducto[index].descripcion +
                  " \nPrecio: " +
                  listaProducto[index].precio.toString()),
            );
          });
    }
  }
}
