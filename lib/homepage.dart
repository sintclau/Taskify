import 'package:flutter/material.dart';
import 'package:taskify/utils/custom_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar(),
          Padding(
            padding: const EdgeInsets.only(left: 35, top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome back, Claudiu!",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                Column(
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.work,
                          size: 25,
                          color: Color.fromARGB(255, 255, 108, 68),
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Projects",
                          style: TextStyle(
                            fontSize: 30,
                            color: Color.fromARGB(255, 255, 108, 68),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(23)),
                          color: Colors.black12,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Stack(children: [
                            const Text("Tasks"),
                          ]),
                        ),
                      ),
                    ]),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
