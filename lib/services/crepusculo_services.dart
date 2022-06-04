// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_final/models/book_models.dart';

class CrepusculoServices extends ChangeNotifier {
  final String _url = "www.googleapis.com";
  final String _apiKey = "AIzaSyDtmX7CTfc59FFO2vTnTb_gEo2kQ33fNNY";

  List<Book> propiedadesLibro = [];

  CrepusculoServices() {
    obtenerServicios();
  }
  Future obtenerServicios() async {
    //Se conectara a la API con los datos que tenemos

    // ignore: unnecessary_brace_in_string_interps
    final url = Uri.https(_url, '/books/v1/volumes', {'q': 'crepusculo'});
    //Como la funcion espera la peticion al servidor se hace de forma asincrona
    final respuesta = await http.get(url, headers: {'x-api-key': _apiKey});
    final libros = Books.fromJson(respuesta.body);

    propiedadesLibro = libros.items!;
    notifyListeners();
  }
}
