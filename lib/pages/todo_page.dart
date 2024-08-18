import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/pages/about.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final _myBox = Hive.box('myBox');
  List<String> todos = [];

  TextEditingController myController = TextEditingController();


  
  @override
  void initState() {
    super.initState();
    List<String>? storedTodos = _myBox.get('todos')?.cast<String>();
    if (storedTodos != null && storedTodos.isNotEmpty) {
      todos = storedTodos;
    } else {
      todos = ["wash the car", "clean the house"];
      _myBox.put('todos', todos);
    }
  }

  // DEBUG
  // @override
  // void initState() {
  //   super.initState();
  //   print("Retrieving todos from Hive");
  //   List<String>? storedTodos = _myBox.get('todos')?.cast<String>();
  //   print("Stored todos: $storedTodos");
  //   if (storedTodos != null && storedTodos.isNotEmpty) {
  //     todos = storedTodos;
  //   } else {
  //     todos = ["wash the car", "clean the house"];
  //     _myBox.put('todos', todos);
  //   }
  //   print("Final todos list: $todos");
  // }

  void addToDo() {
    setState(() {
      todos.add(myController.text.toString());
    });

    _myBox.put('todos', todos);
    myController.clear();
  }

  void removeToDo(int index) {
    setState(() {
      todos.removeAt(index);
    });
    _myBox.put('todos', todos);
  }

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favour's ToDo App"),
        elevation: 0,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
                child: Icon(
              Icons.abc_outlined,
              size: 90,
            ),),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    if (currentRoute != '/homepage') {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/homepage');
                    }
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 11.5, top: 11, bottom: 11),
                        child: Icon(
                          Icons.home,
                          color: Colors.deepPurple[300],
                          size: 30,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 11, bottom: 11),
                        child: Text(
                          'H O M E',
                          style: TextStyle(fontSize: 24, color: currentRoute == '/homepage' ? Colors.deepPurple[300] : Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    if (currentRoute != '/aboutpage') {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/aboutpage');
                    }
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 11.5, top: 11, bottom: 11),
                        child: Icon(Icons.question_answer_rounded,
                            color: Colors.deepPurple[300], size: 26),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0, top: 11, bottom: 11),
                        child: Text(
                          'A B O U T',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),




      body: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            todos.isEmpty
                ? const Center(
                    child: Text('No todos available. Add some tasks!'))
                : Expanded(
                    child: ListView.builder(
                      itemCount: todos.length,
                      itemBuilder: (context, index) => Container(
                        // num = index;
                        padding: const EdgeInsets.only(left: 20),
                        margin:
                            const EdgeInsets.only(top: 10, left: 15, right: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.deepPurple[300],
                        ),

                        height: 100,
                        width: 200,

                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                todos[index],
                                style: const TextStyle(
                                    fontSize: 21,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(right: 15),
                              child: FloatingActionButton(
                                onPressed: () {
                                  removeToDo(index);
                                },
                                child: const Icon(
                                  Icons.delete,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

            // Text('Hello World'),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 15),
                  margin: const EdgeInsets.only(right: 5, bottom: 14),
                  width: screenWidth * 0.72,
                  child: TextField(
                    autofocus: true,
                    maxLength: 20,
                    controller: myController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25))),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 15),
                  margin: const EdgeInsets.only(right: 5, bottom: 38),
                  child: FloatingActionButton(
                    onPressed: addToDo,
                    child: const Icon(Icons.add),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

//
// ListView.builder(
// itemCount: todos.length,
// itemBuilder: (context, index) => Container(
// padding: const EdgeInsets.only(left: 20),
// margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(25),
// color: Colors.yellow[400],
//
// ),
// // border: BorderRadius.circular(25),
// height: 100,
// width: 200,
//
// child: Row(
//
// children: [
// Expanded(
// child: Text(todos[index], style: const TextStyle(fontSize: 21),),
// ),
// ],
// ),
//
// ),
//
//
// ),
