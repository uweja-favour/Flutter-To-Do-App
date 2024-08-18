import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/pages/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _myBox = Hive.box('myBox');


  TextEditingController loginTextEditingController = TextEditingController();
  String passWord = '0000';
  bool haveAnAccount = false;

  String? incorrectPassword;


  @override
  void initState() {
    super.initState();

    String getPassWord = _myBox.get('password', defaultValue: '0000');
    if (getPassWord != null) {
      passWord = getPassWord;
    }

    bool? accountExist = _myBox.get('haveAnAccount');
    if (accountExist.runtimeType == bool && accountExist != null) {
      haveAnAccount = accountExist;
    }

  }

  void verifyPassword() {
    String enteredPassword = loginTextEditingController.text;
    loginTextEditingController.clear();
    if (enteredPassword == passWord || enteredPassword == '0000') {
      Navigator.pop(context);
      Navigator.pushNamed(context, '/homepage');
    } else {
      setState(() {
        incorrectPassword = 'Incorrect Password';
      });

    }
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(fontSize: 24),
        ),
      ),
      body: Center(
        child: Expanded(
          child: Column(
            children: [
              const Icon(Icons.abc, size: 90,),

              Container(
                margin: const EdgeInsets.only(bottom: 19),
                // padding: EdgeInsets.only(bottom: 18.0),
                child: const Text('Login to continue'),
              ),
              SizedBox(
                width: screenWidth * 0.9,
                child: TextField(
                  controller: loginTextEditingController,
                  decoration: InputDecoration(
                    errorText: incorrectPassword,
                    alignLabelWithHint: true,
                    hintText: 'Enter password',
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
                    // submit password for verification
                      verifyPassword();
                    },
                  child: const Text('Submit', style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal))
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                      context,
                      'signuppage'
                    );
                },
                child: haveAnAccount ? const Text("") :  const Padding(
                  padding: EdgeInsets.only(top: 18.0),
                  child: Text("Don't have an account? Sign Up", style: TextStyle(color: Colors.blueAccent),),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
