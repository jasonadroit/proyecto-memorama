import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';

class GameScreen extends StatefulWidget {
  final int pairs;

  GameScreen({required this.pairs});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<String> _cards = [];
  List<bool> _revealed = [];
  int _moves = 0;
  int _timeElapsed = 0;
  Timer? _timer;
  int? _firstSelected;
  int? _secondSelected;
  bool _isChecking = false;

  @override
  void initState() {
    super.initState();
    _initializeGame();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _initializeGame() {
    // Crear pares de cartas con un total correspondiente a widget.pairs
    _cards = List.generate(widget.pairs, (index) => 'card_$index')
      ..addAll(List.generate(widget.pairs, (index) => 'card_$index'))
      ..shuffle(Random());

    _revealed = List.generate(_cards.length, (index) => false);
    _moves = 0;
    _timeElapsed = 0;
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _timeElapsed++;
      });
    });
  }

  void _onCardTap(int index) {
    if (_isChecking || _revealed[index]) return;

    setState(() {
      if (_firstSelected == null) {
        _firstSelected = index;
        _revealed[index] = true;
      } else if (_secondSelected == null) {
        _secondSelected = index;
        _revealed[index] = true;
        _moves++; // Incrementa los movimientos
        _isChecking = true;

        // Verificar si las cartas coinciden después de una pausa breve
        Future.delayed(Duration(milliseconds: 500), () {
          setState(() {
            if (_cards[_firstSelected!] == _cards[_secondSelected!]) {
              // Las cartas coinciden, dejarlas reveladas
              _firstSelected = null;
              _secondSelected = null;
            } else {
              // Las cartas no coinciden, voltearlas de nuevo
              _revealed[_firstSelected!] = false;
              _revealed[_secondSelected!] = false;
              _firstSelected = null;
              _secondSelected = null;
            }
            _isChecking = false;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        title: Text('Juego de Memorama - ${widget.pairs} Pares'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Tiempo: $_timeElapsed s',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'Intentos: $_moves',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              padding: const EdgeInsets.all(16.0),
              itemCount: _cards.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _onCardTap(index),
                  child: Card(
                    color: Colors.white,
                    child: Center(
                      child: _revealed[index]
                          ? Image.asset(
                              _cards[index]) // Mostrar imagen de la carta
                          : Image.asset(
                              'assets/images/card_back.png'), // Imagen trasera
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
