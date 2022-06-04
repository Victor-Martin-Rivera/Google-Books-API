import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/Screens/datos_gabriel.dart';
import 'package:proyecto_final/services/gabriel_services.dart';
import '../models/book_models.dart';

class SearchGabrielDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_rounded));
  }

  //Sugerencias
  @override
  Widget buildSuggestions(BuildContext context) {
    final pauloServices = Provider.of<GabrielServices>(context);
    List<Book> listGabriel = [];
    /*Creo una variable y si la consulta es vacia que me muestre todos los libros y si no que me muestre
    todos los titulos de los libros que empiecen con mi consulta*/

    listGabriel = query.isEmpty
        ? pauloServices.propiedadesLibro
        : pauloServices.propiedadesLibro
            .where((paulo) => paulo.volumeInfo!.title
                .toLowerCase()
                .trim()
                .toUpperCase()
                .contains(query.toLowerCase().trim().toUpperCase()))
            .toList();

    if (listGabriel.isEmpty) {
      return Center(
        child: Column(
          //Centra el texto y el icono
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.search_off_rounded,
              size: 100,
              color: Colors.grey,
            ),
            Text('No data found...',
                style: TextStyle(fontSize: 40, color: Colors.grey)),
          ],
        ),
      );
    } else {
      return ListView.builder(
        //Regresa la longitud de la lista
        itemCount: listGabriel.length,
        itemBuilder: (context, index) {
          final listitem = listGabriel[index];
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
                        onTap: () {
                          showResults(context);
                        },
                        trailing: const Icon(Icons.arrow_forward_ios_outlined),
                        title: Text(
                          //Operacion ternaria para saber cargar los titulos de libros
                          listitem.volumeInfo!.title,
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w400),
                        ),
                        //Operacion ternaria para mostrar imagen
                        leading:
                            (listitem.volumeInfo!.imageLinks?.thumbnail) == null
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
                                                listitem.volumeInfo!.imageLinks!
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
  }

  //Resultados
  @override
  Widget buildResults(BuildContext context) {
    final librosServices = Provider.of<GabrielServices>(context);
    List<Book> listPaulo = [];
    /*Creo una variable y si la consulta es vacia que me muestre todos los libros y si no que me muestre
    todos los titulos de los libros que empiecen con mi consulta*/

    listPaulo = query.isEmpty
        ? librosServices.propiedadesLibro
        : librosServices.propiedadesLibro
            .where((gabriel) => gabriel.volumeInfo!.title
                .toLowerCase()
                .trim()
                .toUpperCase()
                .contains(query.toLowerCase().trim().toUpperCase()))
            .toList();

    if (listPaulo.isEmpty) {
      return Center(
        child: Column(
          //Centra el texto y el icono
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.search_off_rounded,
              size: 100,
              color: Colors.grey,
            ),
            Text('No data found...',
                style: TextStyle(fontSize: 40, color: Colors.grey)),
          ],
        ),
      );
    } else {
      return ListView.builder(
        //Regresa la longitud de la lista
        itemCount: listPaulo.length,
        itemBuilder: (context, index) {
          final listitem = listPaulo[index];
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
                        onTap: () {
                          Book idPaulo = listPaulo[index];
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DatosGabriel(index, listPaulo, idPaulo)));
                        },
                        trailing: const Icon(Icons.arrow_forward_ios_outlined),
                        title: Text(
                          //Operacion ternaria para saber cargar los titulos de libros
                          listitem.volumeInfo!.title,
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w400),
                        ),
                        //Operacion ternaria para mostrar imagen
                        leading:
                            (listitem.volumeInfo!.imageLinks?.thumbnail) == null
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
                                                listitem.volumeInfo!.imageLinks!
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
  }
}
