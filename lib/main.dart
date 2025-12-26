import 'package:flutter/material.dart';
import 'todo_sceen.dart';

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
        appBar: AppBar(
          title: const Text('App bar title: Todo App'),
        ),
        body: Center(child: TodoScreen()),
      ),
    );
  }
}