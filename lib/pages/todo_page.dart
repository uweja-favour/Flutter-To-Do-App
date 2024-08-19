import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

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
      todos = [];
      _myBox.put('todos', todos);
    }
  }

  void addToDo() {
    setState(() {
      todos.add(myController.text);
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
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Favour's ToDo App"),
        elevation: 0,
      ),
      // drawer: Drawer(
      //   child: Column(
      //     children: [
      //       const DrawerHeader(
      //         child: Icon(
      //           Icons.abc_outlined,
      //           size: 90,
      //         ),
      //       ),
      //       Column(
      //         children: [
      //           GestureDetector(
      //             onTap: () {
      //               if (currentRoute != '/homepage') {
      //                 Navigator.pop(context);
      //                 Navigator.pushNamed(context, '/homepage');
      //               }
      //             },
      //             child: Row(
      //               children: [
      //                 Padding(
      //                   padding: const EdgeInsets.only(left: 11.5, top: 11, bottom: 11),
      //                   child: Icon(
      //                     Icons.home,
      //                     color: Colors.deepPurple[300],
      //                     size: 30,
      //                   ),
      //                 ),
      //                 Padding(
      //                   padding: const EdgeInsets.only(left: 8.0, top: 11, bottom: 11),
      //                   child: Text(
      //                     'H O M E',
      //                     style: TextStyle(fontSize: 24, color: currentRoute == '/homepage' ? Colors.deepPurple[300] : Colors.black),
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //           GestureDetector(
      //             onTap: () {
      //               if (currentRoute != '/aboutpage') {
      //                 Navigator.pop(context);
      //                 Navigator.pushNamed(context, '/aboutpage');
      //               }
      //             },
      //             child: Row(
      //               children: [
      //                 Padding(
      //                   padding: const EdgeInsets.only(left: 11.5, top: 11, bottom: 11),
      //                   child: Icon(Icons.question_answer_rounded,
      //                       color: Colors.deepPurple[300], size: 26),
      //                 ),
      //                 const Padding(
      //                   padding: EdgeInsets.only(left: 8.0, top: 11, bottom: 11),
      //                   child: Text(
      //                     'A B O U T',
      //                     style: TextStyle(fontSize: 24),
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ],
      //       )
      //     ],
      //   ),
      // ),

      drawer: Drawer(
        child: Column(
          children: [
            // Drawer Header with user profile
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurple[300],
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Center(child: Icon(Icons.abc, size: 90, color: Colors.white,))
                ],
              ),
            ),

            // Navigation Items
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    leading: Icon(Icons.home, color: Colors.deepPurple[300]),
                    title: const Text('Home', style: TextStyle(fontSize: 18)),
                    onTap: () {
                      if (currentRoute != '/homepage') {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/homepage');
                      }
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.question_answer_rounded, color: Colors.deepPurple[300]),
                    title: const Text('About', style: TextStyle(fontSize: 18)),
                    onTap: () {
                      if (currentRoute != '/aboutpage') {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/aboutpage');
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      body: Center(
        child: SizedBox(
          width: screenWidth * 0.95,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              todos.isEmpty
                  ? const Expanded(
                child: Center(
                  child: Text('No todos available. Add some tasks!'),
                ),
              )

              : Expanded(
                child: ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context, index) => Card(
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5, // Adds shadow to the card
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      leading: Text(
                        todos[index],
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.normal
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.deepPurple[300]),
                        onPressed: () {
                          removeToDo(index);
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Input TextField
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: myController,
                        maxLength: 20,
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: 'Enter task',
                          hintStyle: TextStyle(color: Colors.grey[500]),
                          border: InputBorder.none,
                          counterText: '',
                          icon: Icon(
                            Icons.task_alt,
                            color: Colors.deepPurple[300],
                          ),
                        ),
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  // FloatingActionButton
                  Container(
                    margin: const EdgeInsets.only(left: 8, bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: FloatingActionButton(
                      onPressed: addToDo,
                      backgroundColor: Colors.deepPurple[300],
                      elevation: 5,
                      child: const Icon(
                        Icons.add,
                        size: 28,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
