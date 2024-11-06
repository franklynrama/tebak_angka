import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(TebakAngkaApp());
}

class TebakAngkaApp extends StatelessWidget {
  const TebakAngkaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tebak Angka 1-100',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.teal[50],
      ),
      home: TebakAngkaPage(),
    );
  }
}

class TebakAngkaPage extends StatefulWidget {
  const TebakAngkaPage({super.key});

  @override
  _TebakAngkaPageState createState() => _TebakAngkaPageState();
}

class _TebakAngkaPageState extends State<TebakAngkaPage> {
  final TextEditingController _controller = TextEditingController();
  int _targetNumber = Random().nextInt(100) + 1;
  String _feedbackMessage = '';
  bool _isCorrect = false;

  void _checkGuess() {
    setState(() {
      int? guess = int.tryParse(_controller.text);
      if (guess == null || guess < 1 || guess > 100) {
        _feedbackMessage = 'Masukkan angka valid antara 1 hingga 100.';
        _isCorrect = false;
      } else if (guess < _targetNumber) {
        _feedbackMessage = 'Terlalu rendah!';
        _isCorrect = false;
      } else if (guess > _targetNumber) {
        _feedbackMessage = 'Terlalu tinggi!';
        _isCorrect = false;
      } else {
        _feedbackMessage = 'Selamat! Anda menebak dengan benar!';
        _isCorrect = true;
      }
    });
  }

  void _resetGame() {
    setState(() {
      _targetNumber = Random().nextInt(100) + 1;
      _controller.clear();
      _feedbackMessage = '';
      _isCorrect = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tebak Angka 1-100'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Tebak angka antara 1 hingga 100',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[800],
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      labelText: 'Masukkan tebakan Anda',
                      labelStyle: const TextStyle(color: Colors.teal),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    enabled: !_isCorrect, // Disable input jika tebakan benar
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _isCorrect ? null : _checkGuess,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isCorrect ? Colors.grey : Colors.teal, // Disable tombol jika benar
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Cek',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                if (_isCorrect)
                  ElevatedButton(
                    onPressed: _resetGame,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Reset',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                const SizedBox(height: 20),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _isCorrect ? Colors.green[100] : Colors.red[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _feedbackMessage,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: _isCorrect ? Colors.green[800] : Colors.red[800],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
