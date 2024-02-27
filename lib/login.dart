import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskify/homepage.dart';
import 'package:taskify/register.dart';
import 'package:taskify/utils/color_picker.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 500,
          height: 350,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(48),
            color: AppColors.primaryBlue,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(
                        'Welcome to the login page!',
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // Email
                      Container(
                        margin: EdgeInsets.only(left: 40, right: 40),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(23),
                            color: Colors.white,
                            border: Border.all(
                                color:
                                    const Color.fromARGB(255, 211, 211, 211))),
                        child: Center(
                          child: TextFormField(
                            controller: emailController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Email Address';
                              } else if (!value.contains('@')) {
                                return 'Please enter a valid email address!';
                              }
                              return null;
                            },
                            decoration: const InputDecoration.collapsed(
                                hintText: 'Enter your email address',
                                hintStyle: TextStyle(color: Colors.grey)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // Password
                      Container(
                        margin: EdgeInsets.only(left: 40, right: 40),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(23),
                            color: Colors.white,
                            border: Border.all(
                                color:
                                    const Color.fromARGB(255, 211, 211, 211))),
                        child: Center(
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: true /* Passwords are hidden */,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Password';
                              } else if (value.length < 6) {
                                return 'Password must be atleast 6 characters!';
                              }
                              return null;
                            },
                            decoration: const InputDecoration.collapsed(
                                hintText: 'Enter your password',
                                hintStyle: TextStyle(color: Colors.grey)),
                          ),
                        ),
                      ),
                      // Submit Button
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.lightBlue)),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              logIn();
                            }
                          },
                          child: const Text('Submit'),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage()),
                            );
                          },
                          child: Text('Register'))
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void logIn() {
    // Sign in with email and password on firebase
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((result) async {
      String? userEmail = FirebaseAuth.instance.currentUser!.email;
      FirebaseFirestore.instance
          .collection('users')
          .doc(userEmail)
          .update({'isLoggedIn': true});
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }).catchError((err) {
      print(err.message);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Error"),
              content: Text(err.message),
              actions: [
                ElevatedButton(
                  child: const Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    });
  }
}
