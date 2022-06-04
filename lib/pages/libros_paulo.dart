// ignore_for_file: unnecessary_nullable_for_final_variable_declarations, unrelated_type_equality_checks, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/Screens/datos_coelho.dart';

import 'package:proyecto_final/services/paulo_services.dart';

import 'package:proyecto_final/src/search_paulo_delegate.dart';

class LibrosPaulo extends StatefulWidget {
  const LibrosPaulo({Key? key}) : super(key: key);

  @override
  State<LibrosPaulo> createState() => _LibrosPauloState();
}

class _LibrosPauloState extends State<LibrosPaulo> {
  @override
  Widget build(BuildContext context) {
    final pauloServices = Provider.of<PauloServices>(context);

    if (pauloServices.propiedadesLibro.isEmpty) {
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
        backgroundColor: Colors.orange,
        title: const Text(
          "Paulo Books",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () async {
                showSearch(
                    //Cambio el delegate para consultas a libros de crepusculo
                    context: context,
                    delegate: SearchPauloDelegate());
              },
              icon: const Icon(Icons.search_outlined))
        ],
      ),
      body: Lista(pauloServices),
    );
  }
}

//Extraje el Widget
//Para mostrar la informacion del provider se cambia el nombre del provider
ListView Lista(PauloServices ServicesPaulo) {
  return ListView.builder(
    //Regresa la longitud de la lista
    itemCount: ServicesPaulo.propiedadesLibro.length,
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
                      ServicesPaulo.propiedadesLibro[index].volumeInfo!.title,
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w400),
                    ),
                    //Operacion ternaria para mostrar imagen
                    leading: (ServicesPaulo.propiedadesLibro[index].volumeInfo!
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
                                        ServicesPaulo.propiedadesLibro[index]
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
                              builder: (context) => DatosPaulo(index,
                                  ServicesPaulo.propiedadesLibro, null)));
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
