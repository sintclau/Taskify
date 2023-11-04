import 'package:flutter/material.dart';
import 'package:taskify/utils/cards.dart';
import 'package:taskify/utils/custom_appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:taskify/utils/custom_fab.dart';

final FirebaseFirestore db = FirebaseFirestore.instance;

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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => {print("New task")},
      //   elevation: 10,
      //   backgroundColor: Color.fromARGB(255, 19, 146, 186),
      //   child: Icon(
      //     Icons.add,
      //     color: Colors.white,
      //   ),
      // ),
      floatingActionButton: CustomFab(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar(),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 35, top: 20),
                child: Text(
                  "Welcome back, Claudiu!",
                  style: TextStyle(
                    fontSize: 30,
                    color: Color.fromARGB(255, 27, 26, 31),
                  ),
                ),
              ),
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 35),
                    child: Row(
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
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("projects")
                        .where('members', arrayContains: '1')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final snap = snapshot.data!.docs;
                        if (snap.isEmpty) {
                          return const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("You don't have any projects."),
                            ],
                          );
                        } else {
                          return SizedBox(
                            height: 142,
                            width: double.infinity,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: snap.length,
                              itemBuilder: (context, index) {
                                // Setting project color
                                var color1, color2;
                                if (snap[index]['color'] == "blue") {
                                  color1 = Color.fromARGB(255, 19, 146, 186);
                                  color2 = Color.fromARGB(255, 145, 209, 230);
                                } else if (snap[index]['color'] == "orange") {
                                  color1 = Color.fromARGB(255, 255, 108, 68);
                                  color2 = Color.fromARGB(255, 230, 162, 145);
                                } else if (snap[index]['color'] == "purple") {
                                  color1 = Color.fromARGB(255, 114, 66, 255);
                                  color2 = Color.fromARGB(255, 171, 145, 230);
                                } else {
                                  // Setting default colors
                                  color1 = Color.fromARGB(255, 19, 146, 186);
                                  color2 = Color.fromARGB(255, 145, 209, 230);
                                }

                                // Formatting project creation date
                                DateTime dueDate =
                                    (snap[index]['dueDate'] as Timestamp)
                                        .toDate();
                                String formattedDueDate =
                                    DateFormat('E, d MMM yyyy, kk:mm')
                                        .format(dueDate);

                                // Fluid horizontal scroll
                                if (index == 0) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 35),
                                    child: ProjectCard(
                                        color1,
                                        color2,
                                        snap[index]['name'],
                                        formattedDueDate,
                                        0.2),
                                  );
                                } else {
                                  return ProjectCard(
                                      color1,
                                      color2,
                                      snap[index]['name'],
                                      formattedDueDate,
                                      0.2);
                                }
                              },
                            ),
                          );
                        }
                      } else {
                        return const Text("You don't have any projects.");
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 35),
                    child: Row(
                      children: [
                        Icon(
                          Icons.task,
                          size: 25,
                          color: Color.fromARGB(255, 19, 146, 186),
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Important Tasks",
                          style: TextStyle(
                            fontSize: 30,
                            color: Color.fromARGB(255, 19, 146, 186),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("tasks")
                        .where('assignedTo', arrayContains: '1')
                        .where('priority', isEqualTo: "urgent")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final snap = snapshot.data!.docs;
                        return SizedBox(
                          height: 142,
                          width: double.infinity,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: snap.length,
                            itemBuilder: (context, index) {
                              // Setting project color
                              var color1, color2;
                              if (snap[index]['color'] == "blue") {
                                color1 = Color.fromARGB(255, 19, 146, 186);
                                color2 = Color.fromARGB(255, 145, 209, 230);
                              } else if (snap[index]['color'] == "orange") {
                                color1 = Color.fromARGB(255, 255, 108, 68);
                                color2 = Color.fromARGB(255, 230, 162, 145);
                              } else if (snap[index]['color'] == "purple") {
                                color1 = Color.fromARGB(255, 114, 66, 255);
                                color2 = Color.fromARGB(255, 171, 145, 230);
                              } else {
                                // Setting default colors
                                color1 = Color.fromARGB(255, 19, 146, 186);
                                color2 = Color.fromARGB(255, 145, 209, 230);
                              }

                              // Formatting project creation date
                              DateTime dueDate =
                                  (snap[index]['dueDate'] as Timestamp)
                                      .toDate();
                              String formattedDueDate =
                                  DateFormat('E, d MMM yyyy, kk:mm')
                                      .format(dueDate);

                              // Fluid horizontal scroll
                              if (index == 0) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 35),
                                  child: ProjectCard(
                                      color1,
                                      color2,
                                      snap[index]['name'],
                                      formattedDueDate,
                                      snap[index]['progress']),
                                );
                              } else {
                                return ProjectCard(color1, color2,
                                    snap[index]['name'], formattedDueDate, 0.2);
                              }
                            },
                          ),
                        );
                      } else {
                        return const Text("You don't have any projects.");
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
