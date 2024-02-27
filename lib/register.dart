import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskify/homepage.dart';
import 'package:taskify/utils/color_picker.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
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
          height: 400,
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
                        'Welcome to the register page!',
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // First Name
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
                            controller: firstNameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter your first name';
                              }
                              return null;
                            },
                            decoration: const InputDecoration.collapsed(
                                hintText: 'Enter your first name',
                                hintStyle: TextStyle(color: Colors.grey)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // Last Name
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
                            controller: lastNameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter your last name';
                              }
                              return null;
                            },
                            decoration: const InputDecoration.collapsed(
                                hintText: 'Enter your last name',
                                hintStyle: TextStyle(color: Colors.grey)),
                          ),
                        ),
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
                              register();
                            }
                          },
                          child: const Text('Submit'),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void register() {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((result) async {
      String uniqueId = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseAuth.instance.currentUser!
          .updateDisplayName(firstNameController.text);

      FirebaseFirestore.instance
          .collection("users")
          .doc(emailController.text)
          .set({
        "id": uniqueId,
        "firstName": firstNameController.text,
        "lastName": lastNameController.text,
        "email": emailController.text,
        "isLoggedIn": true,
      }).then((res) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      });
    }).catchError((err) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(err.message),
              actions: [
                TextButton(
                  child: Text("Ok"),
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
