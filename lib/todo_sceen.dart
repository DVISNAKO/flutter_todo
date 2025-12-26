import "package:flutter/material.dart";
import "package:todo_app/models/todo.dart";
import "package:todo_app/widgets/todo_tile.dart";


class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final List<Todo> todos = [];
  final TextEditingController controller = TextEditingController();

  void addTodo() {
    final text = controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      todos.add(Todo(title: text));
    });

    controller.clear();
  }

  void removeTodo(int index) {
    setState(() {
      todos.removeAt(index);
    });
  }

  @override
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
                          onToggle: (value) {
                            setState((){
                              todos[index].isDone = value!;
                            });
                          },
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
