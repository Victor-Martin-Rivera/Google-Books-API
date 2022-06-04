import 'package:flutter/material.dart';
import 'package:proyecto_final/pages/crepusculo.dart';
import 'package:proyecto_final/pages/homepage.dart';
import 'package:proyecto_final/pages/libros_gabriel.dart';
import 'package:proyecto_final/pages/libros_paulo.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int currentTab = 0;

  final List<Widget> screens = [
    const HomePage(),
    const Crepusculo(),
    const LibrosPaulo(),
    const LibrosGabriel()
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const HomePage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      bottomNavigationBar: BottomAppBar(
        //Circular el BottomAppBar
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
          height: 70,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen = const HomePage();
                          currentTab = 0;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //Color del icono si cambia la pantalla
                          ImageIcon(
                            const AssetImage("assets/icons/magic.png"),
                            color: currentTab == 0
                                ? Colors.brown
                                : Colors.brown.shade100,
                          ),
                          Text(
                            "Harry Potter",
                            //Color de letras si se cambia de pantalla
                            style: TextStyle(
                                color: currentTab == 0
                                    ? Colors.brown
                                    : Colors.brown.shade100),
                          )
                        ],
                      ),
                    ),
                    //Segunda pantalla del BottomTabBar
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen = const Crepusculo();
                          currentTab = 1;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.favorite,
                              color: currentTab == 1
                                  ? Colors.red
                                  : Colors.red.shade100),
                          Text(
                            "Crepusculo",
                            style: TextStyle(
                                color: currentTab == 1
                                    ? Colors.red
                                    : Colors.red.shade100),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Tercer BottomTapBar
                      MaterialButton(
                        minWidth: 40,
                        onPressed: () {
                          setState(() {
                            currentScreen = const LibrosPaulo();
                            currentTab = 2;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //Color de la imagen
                            ImageIcon(
                              const AssetImage("assets/icons/book.png"),
                              color: currentTab == 2
                                  ? Colors.orange
                                  : Colors.orange.shade200,
                            ),
                            Text(
                              "Paulo Coelho",
                              style: TextStyle(
                                  color: currentTab == 2
                                      ? Colors.orange
                                      : Colors.orange.shade200),
                            )
                          ],
                        ),
                      ),
                      //Cuarto BottomTapBar
                      MaterialButton(
                        minWidth: 40,
                        onPressed: () {
                          setState(() {
                            currentScreen = const LibrosGabriel();
                            currentTab = 3;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //Color del icono
                            ImageIcon(
                              const AssetImage("assets/icons/Butterfly.png"),
                              color: currentTab == 3
                                  ? Colors.amber
                                  : Colors.amber.shade100,
                            ),
                            //Color del texto
                            Text(
                              "Gabriel",
                              style: TextStyle(
                                  color: currentTab == 3
                                      ? Colors.amber
                                      : Colors.amber.shade100),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
