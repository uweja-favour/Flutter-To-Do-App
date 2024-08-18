import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
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
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0, top: 11, bottom: 11),
                        child: Text(
                          'H O M E',
                          style: TextStyle(fontSize: 24),
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
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 11, bottom: 11),
                        child: Text(
                          'A B O U T',
                          style: TextStyle(fontSize: 24,
                            color: currentRoute == '/aboutpage' ? Colors.deepPurple[300] : Colors.black,),
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

      // body: Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     Text('A B O U T'),
      //     Center(
      //       child: SizedBox(
      //         width: screenWidth * 0.8,
      //         child: const Center(
      //           child: Text(
      //             'This app was built by Uweja Favour Oritsetimeyin on the 17th of August 2024 \n'
      //             '\n'
      //                 'All rights reserved \u00A9 2024'
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 20.0), // Add some padding to position the text
            child: const Text(
              'A B O U T',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Customize the color as needed
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: SizedBox(
                width: screenWidth * 0.8,
                child: const Center(
                  child: Text(
                    'This app was built by Uweja Favour Oritsetimeyin on the 17th of August 2024 \n'
                        '\n'
                        'All rights reserved \u00A9 2024',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16), // Customize text style as needed
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
