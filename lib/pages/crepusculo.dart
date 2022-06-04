// ignore_for_file: unnecessary_nullable_for_final_variable_declarations, unrelated_type_equality_checks, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/Screens/datosCrepusculo.dart';

import 'package:proyecto_final/services/crepusculo_services.dart';
import 'package:proyecto_final/src/search_crepusculo_delegate.dart';

class Crepusculo extends StatefulWidget {
  const Crepusculo({Key? key}) : super(key: key);

  @override
  State<Crepusculo> createState() => _CrepusculoState();
}

class _CrepusculoState extends State<Crepusculo> {
  @override
  Widget build(BuildContext context) {
    final crepusculoServices = Provider.of<CrepusculoServices>(context);

    if (crepusculoServices.propiedadesLibro.isEmpty) {
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
        backgroundColor: Colors.red,
        title: const Text(
          "Crepusculo Books",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () async {
                showSearch(
                    //Cambio el delegate para consultas a libros de crepusculo
                    context: context,
                    delegate: SearchCrepusculoDelegate());
              },
              icon: const Icon(Icons.search_outlined))
        ],
      ),
      body: Lista(crepusculoServices),
    );
  }
}

//Extraje el Widget
//Para mostrar la informacion del provider se cambia el nombre del provider
ListView Lista(CrepusculoServices ServicesCrepusculo) {
  return ListView.builder(
    //Regresa la longitud de la lista
    itemCount: ServicesCrepusculo.propiedadesLibro.length,
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
                      ServicesCrepusculo
                          .propiedadesLibro[index].volumeInfo!.title,
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w400),
                    ),
                    //Operacion ternaria para mostrar imagen
                    leading: (ServicesCrepusculo.propiedadesLibro[index]
                                .volumeInfo!.imageLinks?.thumbnail) ==
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
                                        ServicesCrepusculo
                                            .propiedadesLibro[index]
                                            .volumeInfo!
                                            .imageLinks!
                                            .thumbnail!,
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
                              builder: (context) => DatosCrepusculo(index,
                                  ServicesCrepusculo.propiedadesLibro, null)));
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
