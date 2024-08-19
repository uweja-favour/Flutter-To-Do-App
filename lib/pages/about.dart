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
