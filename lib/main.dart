import 'package:flutter/material.dart';
import 'package:todo_app/pages/home_page.dart';


void main(){
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(child: HomePage()),
      ),
    );
  }
}