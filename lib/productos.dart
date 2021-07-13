class Productos {
  String nombre;
  String descripcion;
  double precio;
  Productos(this.nombre, this.descripcion, this.precio);
}

final listaProducto = [
  //new Productos("Carlos", "Perez", 35),
  // new Productos("Ricardo", "Loza", 35),
  // new Productos("Gonzalo", "Machicado", 35),
  // new Productos("Felipez", "Quiroga", 35),
  // new Productos("Ana", "Moya", 35),
];

void listaCargarP(String nom, String desc, double precio) {
  listaProducto.add(Productos(nom, desc, precio));
}
