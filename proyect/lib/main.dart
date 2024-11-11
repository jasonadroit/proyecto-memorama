import 'package:flutter/material.dart';
import 'game_screen.dart';

void main() {
  runApp(MemoramaApp());
}

class MemoramaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memorama Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Memorama Game'),
      ),
      body: Container(
        color: Colors.blue, // Fondo azul
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Seleccione el número de pares:',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white), // Color del texto blanco
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Centrar los botones en la fila
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent, // Color de fondo
                      foregroundColor: Colors.white, // Color del texto
                      padding: EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15), // Padding
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(30), // Bordes redondeados
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GameScreen(pairs: 8),
                        ),
                      );
                    },
                    child: Text('8 Pares'),
                  ),
                  SizedBox(width: 10), // Espaciado entre botones
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GameScreen(pairs: 10),
                        ),
                      );
                    },
                    child: Text('10 Pares'),
                  ),
                  SizedBox(width: 10), // Espaciado entre botones
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GameScreen(pairs: 12),
                        ),
                      );
                    },
                    child: Text('12 Pares'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
