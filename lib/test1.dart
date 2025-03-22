import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Gesture Demo',
      home: MyHomePage(title: 'Gesture Demo with Snackbar'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: const Center(child: GestureWidget()),
    );
  }
}

class GestureWidget extends StatelessWidget {
  const GestureWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! > 0) {
          // Swipe to the right
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Swiped Right')));
        } else if (details.primaryVelocity! < 0) {
          // Swipe to the left
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Swiped Left')));
        }
      },
      onVerticalDragEnd: (details) {
        if (details.primaryVelocity! > 0) {
          // Swipe down
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Swiped Down')));
        } else if (details.primaryVelocity! < 0) {
          // Swipe up
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Swiped Up')));
        }
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Text(
          'Swipe in any direction',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
