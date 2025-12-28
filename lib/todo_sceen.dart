import "package:flutter/material.dart";
import "package:todo_app/models/todo.dart";
import "package:todo_app/widgets/filter_button.dart";
import "package:todo_app/widgets/todo_tile.dart";
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

enum TodoFilter {
  all,
  completed,
  active,
}

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final List<Todo> todos = [];
  final TextEditingController controller = TextEditingController();
  TodoFilter selectedFilter = TodoFilter.all;

  List<Todo> get filteredTodos {
    switch (selectedFilter) {
      case TodoFilter.active:
        return todos.where((todo) => !todo.isDone).toList();
      case TodoFilter.completed:
        return todos.where((todo) => todo.isDone).toList();
      case TodoFilter.all:
      default:
        return todos;
    }
  }

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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FilterButton(
                  title: 'Все',
                  isActive: selectedFilter == TodoFilter.all,
                  onTap: () {
                    setState(() {
                      selectedFilter = TodoFilter.all;
                    });
                  },
                ),
                FilterButton(
                  title: 'Активные',
                  isActive: selectedFilter == TodoFilter.active,
                  onTap: () {
                    setState(() {
                      selectedFilter = TodoFilter.active;
                    });
                  },
                ),
                FilterButton(
                  title: 'Выполненные',
                  isActive: selectedFilter == TodoFilter.completed,
                  onTap: () {
                    setState(() {
                      selectedFilter = TodoFilter.completed;
                    });
                  },
                ),
              ],
            ),
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
                      itemCount: filteredTodos.length,
                      itemBuilder: (context, index) {
                        final todo = filteredTodos[index];
                        final realIndex = todos.indexOf(todo);

                        return TodoTile(
                          todo: todo,
                          onDelete: () => removeTodo(realIndex),
                          onToggle: (value) => onToggle(realIndex, value),
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

