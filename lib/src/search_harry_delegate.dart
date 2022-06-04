import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/Screens/datosLibros.dart';
import 'package:proyecto_final/services/book_services.dart';
import '../models/book_models.dart';

class SearchHarryDelegate extends SearchDelegate<Book> {
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
    final librosServices = Provider.of<BookServices>(context);
    List<Book> mylist = [];
    /*Creo una variable y si la consulta es vacia que me muestre todos los libros y si no que me muestre
    todos los titulos de los libros que empiecen con mi consulta*/

    mylist = query.isEmpty
        ? librosServices.propiedadesLibro
        : librosServices.propiedadesLibro
            .where((harry) => harry.volumeInfo!.title
                .toLowerCase()
                .trim()
                .toUpperCase()
                .contains(query.toLowerCase().trim().toUpperCase()))
            .toList();

    if (mylist.isEmpty) {
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
        itemCount: mylist.length,
        itemBuilder: (context, index) {
          final listitem = mylist[index];
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
    final librosServices = Provider.of<BookServices>(context);
    List<Book> mylist = [];
    /*Creo una variable y si la consulta es vacia que me muestre todos los libros y si no que me muestre
    todos los titulos de los libros que empiecen con mi consulta*/

    mylist = query.isEmpty
        ? librosServices.propiedadesLibro
        : librosServices.propiedadesLibro
            .where((harry) => harry.volumeInfo!.title
                .toLowerCase()
                .trim()
                .toUpperCase()
                .contains(query.toLowerCase().trim().toUpperCase()))
            .toList();

    if (mylist.isEmpty) {
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
        itemCount: mylist.length,
        itemBuilder: (context, index) {
          final listitem = mylist[index];
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
                          Book id = mylist[index];
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DatosLibros(index, mylist, id)));
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
