import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/pages/login_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  final _myBox = Hive.box('myBox');
  String newPassword = '';
  TextEditingController signUpTextEditingController = TextEditingController();


  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign-Up',
          style: TextStyle(fontSize: 24),
        ),
      ),

      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(Icons.abc, size: 90,),

              Container(
                margin: const EdgeInsets.only(bottom: 19),
                // padding: EdgeInsets.only(bottom: 18.0),
                child: const Text('Sign-Up to continue'),
              ),
              SizedBox(
                width: screenWidth * 0.9,
                child: TextField(
                  controller: signUpTextEditingController,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    hintText: 'Enter password, default password = 0000',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 11.0),
                child: ElevatedButton(
                    onPressed: () {
                      submitPassword();
                    },
                    child: const Text('Submit Password', style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),)
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, '/loginpage');
                },
                child: const Padding(
                  padding: EdgeInsets.only(top: 18.0),
                  child: Text("Already have an account? Sign In", style: TextStyle(color: Colors.blueAccent),),
                ),
              ),
            ],
          ),
      ),
    );
  }

  void submitPassword() {
    newPassword = signUpTextEditingController.text;
    signUpTextEditingController.clear();
    if (newPassword.isNotEmpty) {
      _myBox.put('password', newPassword);
    }
    bool haveAnAccount = true;
    _myBox.put('haveAnAccount', haveAnAccount);
    goToLogInPage();

  }

  void goToLogInPage() {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage())
    );
  }
}

