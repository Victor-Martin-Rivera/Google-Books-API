// ignore_for_file: unnecessary_nullable_for_final_variable_declarations, unrelated_type_equality_checks, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/src/search_harry_delegate.dart';
import 'package:proyecto_final/services/book_services.dart';
import '../Screens/datosLibros.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final librosServices = Provider.of<BookServices>(context);

    if (librosServices.propiedadesLibro.isEmpty) {
      return Container(
        color: Colors.white,
        child: const Center(
            child: CircularProgressIndicator(color: Colors.blueAccent)),
      );
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.brown,
        title: const Text(
          "Harry Potter Books",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: SearchHarryDelegate());
              },
              icon: const Icon(Icons.search_outlined))
        ],
      ),
      body: Lista(librosServices),
    );
  }
}

//Extraje el Widget
ListView Lista(BookServices librosServices) {
  return ListView.builder(
    //Regresa la longitud de la lista
    itemCount: librosServices.propiedadesLibro.length,
    itemBuilder: (context, index) {
      return Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 10, 14),
            child: Card(
              elevation: 10,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40))),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50))),
                height: 100,
                child: Center(
                  child: ListTile(
                    dense: false,
                    trailing: const Icon(Icons.arrow_forward_ios_outlined),
                    title: Text(
                      //Operacion ternaria para saber cargar los titulos de libros
                      librosServices.propiedadesLibro[index].volumeInfo!.title,
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w400),
                    ),
                    //Operacion ternaria para mostrar imagen
                    leading: (librosServices.propiedadesLibro[index].volumeInfo!
                                .imageLinks?.thumbnail) ==
                            null
                        ? Image.asset(
                            "assets/ImagenotFound.jpg",
                            fit: BoxFit.fill,
                          )
                        : Container(
                            constraints: const BoxConstraints(
                                minHeight: 50,
                                minWidth: 60,
                                maxHeight: 65,
                                maxWidth: 80),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: (Image.network(
                                        librosServices.propiedadesLibro[index]
                                            .volumeInfo!.imageLinks!.thumbnail!,
                                        fit: BoxFit.fill,
                                        height: 56,
                                      )),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DatosLibros(index,
                                  librosServices.propiedadesLibro, null)));
                    },
                  ),
                ),
              ),
            ),
          ),
          const Divider(),
        ],
      );
    },
  );
}
