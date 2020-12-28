import 'package:flutter/material.dart';
class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.indigo,
    appBar: AppBar(
      title: Text('About us')
    ),
    body: Text('about us'));
  }
}