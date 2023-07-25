import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int value = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Text(value.toString()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {});
          value++;
          debugPrint(value.toString());
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: Container(
          margin: const EdgeInsets.all(20),
          color: Colors.red,
          height: 50,
          child: const Center(child: Text('Score : 0'))),
    );
  }
}
