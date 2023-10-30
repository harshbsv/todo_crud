import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_crud/helpers/database_helper.dart';
import 'package:todo_crud/models/todo_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dbHelper = DatabaseHelper.instance;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  List<Todo> todos = [];

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  _loadTodos() async {
    final allTodos = await dbHelper.getAllTodos();
    setState(() {
      todos = allTodos;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: const Text(
          'Todo CRUD',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<ProfileScreen>(
                  builder: (context) => ProfileScreen(
                    appBar: AppBar(
                      title: const Text('User Profile'),
                    ),
                    actions: [
                      SignedOutAction((context) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          '/auth',
                          (Route<dynamic> route) => false,
                        );
                      })
                    ],
                    children: const [
                      Divider(),
                      Padding(
                        padding: EdgeInsets.all(2),
                        child: Text('flutterfire_300x.png'),
                      ),
                    ],
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.person,
              color: Colors.grey,
            ),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final todo = todos[index];
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.deepPurple,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        title: Text(
                          todo.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          todo.description,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        trailing: SizedBox(
                          width: 63,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  _showEditTodoDialog(todo);
                                },
                                child: const Icon(Icons.edit),
                              ),
                              const SizedBox(width: 15),
                              InkWell(
                                onTap: () {
                                  _deleteTodo(todo.id!);
                                },
                                child: const Icon(Icons.delete),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Divider(
              color: Colors.purple[100],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Title',
                      labelStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Description',
                      labelStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        _addTodo();
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(size.width, 40),
                      ),
                      child: const Text('Add Todo'),
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _addTodo() async {
    final title = titleController.text;
    final description = descriptionController.text;
    if (title.isNotEmpty && description.isNotEmpty) {
      final newTodo = Todo(title: title, description: description);
      await dbHelper.insertTodo(newTodo);
      titleController.clear();
      descriptionController.clear();
      _loadTodos();
    } else if (title.isEmpty || description.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Please enter Title and Description of your note.',
        fontSize: 15,
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  _editTodo(Todo todo) async {
    final updatedTodo = Todo(
      id: todo.id,
      title: titleController.text,
      description: descriptionController.text,
    );
    await dbHelper.updateTodo(updatedTodo);
    titleController.clear();
    descriptionController.clear();
    _loadTodos();
  }

  _deleteTodo(int id) async {
    await dbHelper.deleteTodo(id);
    _loadTodos();
  }

  _showEditTodoDialog(Todo todo) {
    titleController.text = todo.title;
    descriptionController.text = todo.description;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 50,
          ),
          child: AlertDialog(
            title: const Text('Edit Todo'),
            content: Column(
              children: <Widget>[
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Title',
                    labelStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Expanded(
                  child: TextField(
                    controller: descriptionController,
                    maxLines: descriptionController.text.length,
                    scrollPhysics: const ClampingScrollPhysics(),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Description',
                      labelStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Save'),
                onPressed: () {
                  _editTodo(todo);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
