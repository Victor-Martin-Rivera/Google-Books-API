import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/Widgets/bottomtab.dart';
import 'package:proyecto_final/services/book_services.dart';
import 'package:proyecto_final/services/crepusculo_services.dart';
import 'package:proyecto_final/services/gabriel_services.dart';
import 'package:proyecto_final/services/paulo_services.dart';

void main() => runApp(const BookState());

class BookState extends StatelessWidget {
  const BookState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //Provider de Harry Potter
        ChangeNotifierProvider(
          create: (_) => BookServices(),
        ),
        //Segundo Provider de Crepusculo
        ChangeNotifierProvider(
          create: (_) => CrepusculoServices(),
        ),
        //Tercer Provider de Paulo Coelho
        ChangeNotifierProvider(
          create: (_) => PauloServices(),
        ),
        //Cuarto Provider de Gabriel Garcia
        ChangeNotifierProvider(
          create: (_) => GabrielServices(),
        ),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Proyecto Final',
      theme: ThemeData(primaryColor: Colors.blueAccent),
      home: const Menu(),
    );
  }
}
