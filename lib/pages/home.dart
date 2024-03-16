import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home ({super.key});

  @override
  State<Home> createState() => _State();
}

class _State extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Reviews'),
      ),
    );
  }
}
