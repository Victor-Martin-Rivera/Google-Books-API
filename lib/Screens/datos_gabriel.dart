// ignore_for_file: unused_field, file_names, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/services/gabriel_services.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../models/book_models.dart';

// ignore: must_be_immutable
class DatosGabriel extends StatelessWidget {
  final int estado;
  // ignore: prefer_final_fields
  late List datosLibros = [];
  Book? idGabriel;

  DatosGabriel(
    //Se inicializa en el constructor para obtener los datos
    this.estado,
    this.datosLibros,
    this.idGabriel, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Widget para las alertas
    Widget okButton = TextButton(
        child: const Text("Continue"),
        onPressed: () {
          Navigator.of(context).pop(false);
        });

    final datosServices = Provider.of<GabrielServices>(context);
    //Mientras id sea diferente de nulo, que carguen todos los datos recibidos del delegate
    while (idGabriel != null) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            margin: const EdgeInsets.all(40),
            elevation: 9,
            child: Column(
              children: [
                //Ponerle bordes rectangulares a mi imagen del libro
                ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(50.0)),
                    child: Container(
                      color: Colors.transparent,
                      child: Column(children: [
                        //Muestra el texo en  base a la variable id inicializada en mi constructor
                        ListTile(
                            title: (idGabriel!
                                        .volumeInfo!.imageLinks?.thumbnail) ==
                                    null
                                ? Image.asset(
                                    "assets/ImagenotFound.jpg",
                                    height: 210,
                                    width: 250,
                                  )
                                : (Image.network(
                                    idGabriel!
                                        .volumeInfo!.imageLinks!.thumbnail!,
                                    height: 300,
                                    width: 250,
                                    fit: BoxFit.fill,
                                  ))),
                        const SizedBox(
                          height: 10,
                        ),

                        Text(
                          idGabriel!.volumeInfo!.title,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w500),
                        ),

                        const Divider(
                          color: Colors.blueGrey,
                        ),
                        //Operacion ternaria para mostrar la descripcion
                        ListTile(
                          subtitle: (idGabriel!.volumeInfo!.description) == null
                              ? const Text(
                                  "Descripcion no disponible",
                                  style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold),
                                )
                              : Text(
                                  idGabriel!.volumeInfo!.description!,
                                  style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 17,
                                      height: 1.9),
                                ),
                        ),

                        const SizedBox(
                          height: 15,
                        ),

                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 80, vertical: 10),
                                //OnTap del link de compra
                                child: InkWell(
                                    onTap: () async {
                                      try {
                                        //Hace la peticion al url de mi modelado de clases
                                        await launchUrlString(
                                            idGabriel!.saleInfo!.buyLink!);
                                      } catch (error) {
                                        debugPrint(
                                            'Error inesperado, reinicie la aplicacion');
                                      }
                                    },
                                    child: Container(
                                      width: 70,
                                      height: 50,
                                      decoration: const ShapeDecoration(
                                          //Color de los bordes
                                          shape: CircleBorder(),
                                          color: Colors.greenAccent),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.greenAccent),
                                        child: Center(
                                          //Operacion ternaria para entrar al link de compra
                                          child: (idGabriel!
                                                      .saleInfo!.buyLink) ==
                                                  null
                                              ? IconButton(
                                                  icon: const Icon(
                                                    Icons.remove_shopping_cart,
                                                    size: 30,
                                                  ),
                                                  color: Colors.white,
                                                  onPressed: () {
                                                    //AlertDialog muestra una alerta al presionar el boton
                                                    AlertDialog alert =
                                                        AlertDialog(
                                                      title:
                                                          const Text("Error"),
                                                      content: const Text(
                                                          "No books found"),
                                                      actions: [
                                                        okButton,
                                                      ],
                                                    );
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return alert;
                                                        });
                                                  },
                                                )
                                              : const Icon(
                                                  Icons.shopping_cart,
                                                  size: 30,
                                                  color: Colors.white,
                                                ),
                                        ),
                                      ),
                                    )),
                              ),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 80, vertical: 10),
                                //Link para comprar libro
                                child: InkWell(
                                    //OnTap del pdf
                                    onTap: () async {
                                      try {
                                        //Hace la peticion al url de mi modelado de clases
                                        await launchUrlString(idGabriel!
                                            .accessInfo!.webReaderLink!);
                                      } catch (error) {
                                        debugPrint(
                                            'Error inesperado, reinicie la aplicacion');
                                      }
                                    },
                                    child: Container(
                                      width: 70,
                                      height: 50,
                                      decoration: const ShapeDecoration(
                                          //Color de los bordes
                                          shape: CircleBorder(),
                                          color: Colors.redAccent),
                                      //Color del contenedor (Rojo)
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.redAccent),
                                        //Link de compra
                                        child: Center(
                                          child: (idGabriel!
                                                      .saleInfo!.buyLink) ==
                                                  null
                                              ? IconButton(
                                                  icon: const Icon(
                                                    Icons.error,
                                                    size: 30,
                                                  ),
                                                  color: Colors.white,
                                                  //Al presionarlo arroja una alerta traido de un widget
                                                  onPressed: () {
                                                    AlertDialog alert =
                                                        AlertDialog(
                                                      title:
                                                          const Text("Error"),
                                                      content: const Text(
                                                          "No PDF Available"),
                                                      actions: [
                                                        okButton,
                                                      ],
                                                    );
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return alert;
                                                        });
                                                  },
                                                )
                                              : const Icon(
                                                  Icons.picture_as_pdf,
                                                  size: 30,
                                                  color: Colors.white,
                                                ),
                                        ),
                                      ),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ]),
                    ))
              ],
            ),
          ),
        ),
      );
    }

    //Diseño para la segunda pantalla
    return Scaffold(
      body: SingleChildScrollView(
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          margin: const EdgeInsets.all(40),
          elevation: 9,
          child: Column(
            children: [
              //Ponerle bordes rectangulares a mi imagen del libro
              ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(50.0)),
                  child: Container(
                    color: Colors.transparent,
                    child: Column(children: [
                      ListTile(
                          title: (datosServices.propiedadesLibro[estado]
                                      .volumeInfo!.imageLinks?.thumbnail) ==
                                  null
                              ? Image.asset(
                                  "assets/ImagenotFound.jpg",
                                  height: 210,
                                  width: 250,
                                )
                              : (Image.network(
                                  datosServices.propiedadesLibro[estado]
                                      .volumeInfo!.imageLinks!.thumbnail!,
                                  height: 300,
                                  width: 250,
                                  fit: BoxFit.fill,
                                ))),
                      const SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        title: Text(
                          datosServices
                              .propiedadesLibro[estado].volumeInfo!.title,
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w500),
                        ),
                      ),
                      const Divider(
                        color: Colors.blueGrey,
                      ),
                      ListTile(
                        subtitle: (datosServices.propiedadesLibro[estado]
                                    .volumeInfo!.description) ==
                                null
                            ? const Text(
                                "Descripcion no disponible",
                                style: TextStyle(
                                    fontSize: 32, fontWeight: FontWeight.bold),
                              )
                            : Text(
                                datosServices.propiedadesLibro[estado]
                                    .volumeInfo!.description!,
                                style: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 17,
                                    height: 1.9),
                              ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 80, vertical: 10),
                              child: InkWell(
                                  //OnTap del link de compra para SearchDelegate
                                  onTap: () async {
                                    try {
                                      //Hace la peticion al url de mi modelado de clases
                                      await launchUrlString(datosServices
                                          .propiedadesLibro[estado]
                                          .saleInfo!
                                          .buyLink!);
                                    } catch (error) {
                                      debugPrint(
                                          'Error inesperado, reinicie la aplicacion');
                                    }
                                  },
                                  child: Container(
                                    width: 70,
                                    height: 50,
                                    decoration: const ShapeDecoration(
                                        //Color de los bordes
                                        shape: CircleBorder(),
                                        color: Colors.greenAccent),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.greenAccent),
                                      child: Center(
                                        child: (datosServices
                                                    .propiedadesLibro[estado]
                                                    .saleInfo!
                                                    .buyLink) ==
                                                null
                                            ? IconButton(
                                                icon: const Icon(
                                                  Icons.remove_shopping_cart,
                                                  size: 30,
                                                ),
                                                color: Colors.white,
                                                onPressed: () {
                                                  AlertDialog alert =
                                                      AlertDialog(
                                                    title: const Text("Error"),
                                                    content: const Text(
                                                        "No books found"),
                                                    actions: [
                                                      okButton,
                                                    ],
                                                  );
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return alert;
                                                      });
                                                },
                                              )
                                            : const Icon(
                                                Icons.shopping_cart,
                                                size: 30,
                                                color: Colors.white,
                                              ),
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 80, vertical: 10),
                              //Link para comprar libro
                              child: InkWell(
                                  //OnTap del pdf de SearchDelegate
                                  onTap: () async {
                                    try {
                                      //Hace la peticion al url de mi modelado de clases
                                      await launchUrlString(datosServices
                                          .propiedadesLibro[estado]
                                          .accessInfo!
                                          .webReaderLink!);
                                    } catch (error) {
                                      debugPrint(
                                          'Error inesperado, reinicie la aplicacion');
                                    }
                                  },
                                  child: Container(
                                    width: 70,
                                    height: 50,
                                    decoration: const ShapeDecoration(
                                        //Color de los bordes
                                        shape: CircleBorder(),
                                        color: Colors.redAccent),
                                    //Color del contenedor (Rojo)
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.redAccent),
                                      //Link de compra
                                      child: Center(
                                        child: (datosServices
                                                    .propiedadesLibro[estado]
                                                    .saleInfo!
                                                    .buyLink) ==
                                                null
                                            ? IconButton(
                                                icon: const Icon(
                                                  Icons.error,
                                                  size: 30,
                                                ),
                                                color: Colors.white,
                                                //Al presionarlo arroja una alerta traido de un widget
                                                onPressed: () {
                                                  AlertDialog alert =
                                                      AlertDialog(
                                                    title: const Text("Error"),
                                                    content: const Text(
                                                        "No PDF Available"),
                                                    actions: [
                                                      okButton,
                                                    ],
                                                  );
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return alert;
                                                      });
                                                },
                                              )
                                            : const Icon(
                                                Icons.picture_as_pdf,
                                                size: 30,
                                                color: Colors.white,
                                              ),
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ]),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
