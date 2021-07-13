//@dart=2.9

import 'package:registro/main.dart';
import 'package:registro/pantalla1.dart';
import 'package:registro/pantalla2.dart';
import 'package:flutter/material.dart';
import 'package:registro/pantalla3.dart';

class MenuLateral extends StatefulWidget {
  @override
  _MenuLateralState createState() => _MenuLateralState();
}

class _MenuLateralState extends State<MenuLateral> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("Curso Flutter"),
            accountEmail: Text("themaster@gmail.com"),
            // currentAccountPicture: Image.asset("imagenes/comandante.jpg"),
          ),
          ListTile(
            title: Text("Home"),
            leading: Icon(Icons.directions_bike_outlined),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return Principal();
              }));

              print("Home");
            },
          ),
          ListTile(
              title: Text("Insertar"),
              leading: Icon(Icons.add_sharp),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return Pantalla1();
                }));

                print("pantalla 1");
              }),
          ListTile(
            title: Text("Modificar"),
            leading: Icon(Icons.confirmation_num_rounded),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return Pantalla2();
              }));
              print("pantalla 2");
            },
          ),
          ListTile(
            title: Text("Eliminar"),
            leading: Icon(Icons.minimize_sharp),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return Pantalla3();
              }));
              print("pantalla 3");
            },
          )
        ],
      ),
    );
  }
}
