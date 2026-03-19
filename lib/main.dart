import 'package:flutter/material.dart';

// Точка вхождения в приложение
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.black,
        fontFamily: 'Ubuntu',
        scaffoldBackgroundColor: Colors.black,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'TSU Maps',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontStyle: FontStyle.normal,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: Center(
          child: Text(
            'TSU Maps',
            style: TextStyle(
              fontSize: 50,
              color: Colors.white,
              fontStyle: FontStyle.normal,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.orange,
          child: Text('Нажми'),
        ),
      ),
    );
  }
}
