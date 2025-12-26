import "package:flutter/material.dart";
import "package:todo_app/models/todo.dart";
import "package:todo_app/widgets/todo_tile.dart";
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final List<Todo> todos = [];
  final TextEditingController controller = TextEditingController();

  Future<void> saveTodos() async {
    final prefs = await SharedPreferences.getInstance();

    final todosJson = todos.map((todo) => jsonEncode(todo.toJson())).toList();

    await prefs.setStringList('todos', todosJson);
  }

  Future<void> loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final todosJson = prefs.getStringList('todos');

    if (todosJson == null) return;

    setState(() {
      todos.clear();
      todos.addAll(todosJson.map((item) => Todo.fromJson(jsonDecode(item))));
    });
  }

  void addTodo() {
    final text = controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      todos.add(Todo(title: text));
    });

    saveTodos();

    controller.clear();
  }

  void removeTodo(int index) {
    setState(() {
      todos.removeAt(index);
    });

    saveTodos();
  }

  void onToggle(int index, bool? value) {
    setState(() {
      todos[index].isDone = value!;
    });

    saveTodos();
  }

  @override
  void initState() {
    super.initState();
    loadTodos();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Todo screens Appbar title")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: "Введите задачу",
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    addTodo();
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: todos.isEmpty
                  ? const Center(child: Text('Задач пока нет'))
                  : ListView.builder(
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        return TodoTile(
                          todo: todos[index],
                          onDelete: () => removeTodo(index),
                          onToggle: (value) => onToggle(index, value),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
