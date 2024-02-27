import 'dart:js_interop';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:side_sheet/side_sheet.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:taskify/utils/color_picker.dart';

final double buttonSize = 70;

class CustomFab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CustomFabState();
}

class _CustomFabState extends State<CustomFab>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  final _formKey = GlobalKey<FormState>();
  TextEditingController taskNameController = TextEditingController();
  TextEditingController taskDescriptionController = TextEditingController();
  TextEditingController taskAssignedToController = TextEditingController();
  late Color taskColorPicker;
  TextEditingController taskProjectController = TextEditingController();
  TextEditingController taskTeamController = TextEditingController();
  TextEditingController taskPriorityController = TextEditingController();
  TextEditingController taskDueDateController = TextEditingController();

  @override
  void initState() {
    super.initState();

    taskColorPicker = const Color.fromARGB(255, 19, 146, 186);

    controller = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Flow(
        delegate: FlowMenuDelegate(controller: controller),
        children: <IconData>[
          Icons.task,
          Icons.work,
          Icons.people,
          Icons.add,
        ].map<Widget>(buildFAB).toList(),
      );

  Widget buildFAB(IconData icon) => SizedBox(
        width: buttonSize,
        height: buttonSize,
        child: FloatingActionButton(
          elevation: 0,
          hoverElevation: 3,
          backgroundColor: const Color.fromARGB(255, 19, 146, 186),
          shape: const OvalBorder(),
          child: Icon(
            icon,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () async {
            if (icon == Icons.task) {
              // Prepare user project list for selection
              List<String> userProjectNames = await getUserProjectNames('1');
              userProjectNames.add("No project");

              // Prepare priority list for selection
              var prioritySelector = ["High", "Medium", "Low"];

              // Prepare team list for selection
              String userTeam = await getUserTeam('1');
              bool userHasTeam;
              if (userTeam == "You aren't part of a team") {
                userHasTeam = false;
              } else {
                userTeam = 'Assign the task to your team "$userTeam"?';
                userHasTeam = true;
              }
              var teamSelector = ['Yes', 'No'];

              // ignore: use_build_context_synchronously
              SideSheet.right(
                context: context,
                // width: MediaQuery.of(context).size.width * 0.3,
                body: Padding(
                  padding: const EdgeInsets.only(
                      left: 35, top: 20, right: 35, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.task,
                                color: Color.fromARGB(255, 19, 146, 186),
                                size: 25,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "New task",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 19, 146, 186),
                                    fontSize: 35),
                              ),
                            ],
                          ),
                          FloatingActionButton.small(
                            elevation: 0,
                            shape: const CircleBorder(),
                            backgroundColor:
                                const Color.fromARGB(255, 233, 25, 25),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                "Task Name",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 19, 146, 186),
                                    fontSize: 20),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(23),
                                  color: Colors.white,
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 211, 211, 211))),
                              child: Center(
                                child: TextField(
                                  controller: taskNameController,
                                  decoration: const InputDecoration.collapsed(
                                      hintText: 'Enter a name',
                                      hintStyle: TextStyle(color: Colors.grey)),
                                ),
                              ),
                            ),
                            // Padding
                            const SizedBox(
                              height: 20,
                            ),
                            // Task Description Input
                            const Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                "Task Description",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 19, 146, 186),
                                    fontSize: 20),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(23),
                                  color: Colors.white,
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 211, 211, 211))),
                              child: Center(
                                child: TextField(
                                  controller: taskDescriptionController,
                                  decoration: const InputDecoration.collapsed(
                                      hintText: 'Enter a description',
                                      hintStyle: TextStyle(color: Colors.grey)),
                                ),
                              ),
                            ),
                            // Padding
                            const SizedBox(
                              height: 20,
                            ),
                            // Task Project Assign Dropdown
                            const Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                "Assign to a project",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 19, 146, 186),
                                    fontSize: 20),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            DropdownButtonFormField(
                              value: "No project", // Initial selected value
                              onChanged: (String? newValue) {
                                setState(() {
                                  taskProjectController.text = newValue ?? '';
                                });
                              },

                              items: userProjectNames.map((String item) {
                                return DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item),
                                );
                              }).toList(),
                            ),
                            // Padding
                            const SizedBox(
                              height: 20,
                            ),
                            // Task Priority Dropdown
                            const Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                "Priority",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 19, 146, 186),
                                    fontSize: 20),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            DropdownButtonFormField(
                              value: "Low", // Initial selected value
                              onChanged: (String? newValue) {
                                setState(() {
                                  taskPriorityController.text = newValue ?? '';
                                });
                              },

                              items: prioritySelector.map((String item) {
                                return DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item),
                                );
                              }).toList(),
                            ),
                            // Padding
                            const SizedBox(
                              height: 20,
                            ),
                            // Task Team Dropdown
                            Visibility(
                              visible: userHasTeam,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text(
                                      userTeam,
                                      style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 19, 146, 186),
                                          fontSize: 20),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  DropdownButtonFormField(
                                    value: "No", // Initial selected value
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        taskPriorityController.text =
                                            newValue ?? '';
                                      });
                                    },
                                    items: teamSelector.map((String item) {
                                      return DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(item),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            // No longer used
                            // ColorPicker(
                            //   color: taskColorPicker,
                            //   onColorChanged: (Color color) => {
                            //     setState(() => taskColorPicker = color),
                            //   },
                            //   pickersEnabled: const <ColorPickerType, bool>{
                            //     ColorPickerType.accent: false,
                            //   },
                            //   heading: Text('Select color'),
                            // ),
                            CustomColorPicker(taskColorPicker, (pickedColor) {
                              setState(() {
                                taskColorPicker = pickedColor;
                              });
                              print(taskColorPicker);
                            }),
                            Container(
                              color: taskColorPicker,
                              child: Text('Selected color'),
                            ),
                            // Submit Button
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.lightBlue)),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    newTask();
                                  }
                                },
                                child: const Text('Create new task'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (icon == Icons.work) {
              print("new project");
            } else if (icon == Icons.people) {
              print("new team");
            }
            if (controller.status == AnimationStatus.completed) {
              controller.reverse();
            } else {
              controller.forward();
            }
          },
        ),
      );

  void newTask() {
    FirebaseFirestore.instance.collection('tasks').add({
      'assignedTo': FirebaseAuth.instance.currentUser!.uid,
      'color': taskColorPicker,
      'createdBy': FirebaseAuth.instance.currentUser!.uid,
      'dateCreated': DateTime.now(),
      'dateDue': DateTime.december,
      'description': taskDescriptionController.text,
      'name': taskNameController.text,
      'progress': 0,
      'priority': taskPriorityController.text,
      'projectId': taskProjectController.text,
      'teamId': taskTeamController.text
    }).then((docRef) {
      FirebaseFirestore.instance
          .collection('tasks')
          .doc(docRef.id)
          .update({'id': docRef.id});
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'tasks': FieldValue.arrayUnion([docRef.id])
      }).then((value) => Navigator.pop(context));
    });
  }
}

class FlowMenuDelegate extends FlowDelegate {
  final Animation<double> controller;

  const FlowMenuDelegate({required this.controller})
      : super(repaint: controller);

  @override
  void paintChildren(FlowPaintingContext context) {
    final size = context.size;
    final xStart = size.width - buttonSize;
    final yStart = size.height - buttonSize;

    final n = context.childCount;
    for (int i = 0; i < n; i++) {
      final isLastItem = i == context.childCount - 1;
      final setValue = (value) => isLastItem ? 0.0 : value;

      final radius = 120 * controller.value;
      final theta = i * pi * 0.5 / (n - 2);
      final x = xStart - setValue(radius * cos(theta));
      final y = yStart - setValue(radius * sin(theta));

      context.paintChild(i,
          transform: Matrix4.identity()
            ..translate(x, y, 0)
            ..translate(buttonSize / 2, buttonSize / 2)
            ..rotateZ(
                isLastItem ? 0.0 : 180 * (1 - controller.value) * pi / 180)
            ..scale(isLastItem ? 1.0 : max(controller.value, 0.5))
            ..translate(-buttonSize / 2, -buttonSize / 2));
    }
  }

  @override
  bool shouldRepaint(FlowMenuDelegate oldDelegate) => false;
}

Future<List<String>> getUserProjectNames(String userId) async {
  final QuerySnapshot projectsSnapshot = await FirebaseFirestore.instance
      .collection('projects')
      .where('members', arrayContains: userId)
      .get();

  final List<String> projectNames =
      projectsSnapshot.docs.map((doc) => doc['name'].toString()).toList();

  return projectNames;
}

Future<String> getUserTeam(String userId) async {
  final DocumentSnapshot teamSnapshot =
      await FirebaseFirestore.instance.collection('users').doc(userId).get();

  if (teamSnapshot.exists) {
    final data = teamSnapshot.data() as Map<String, dynamic>;
    // Check if the document exists
    final userTeam = data[
        'teamId']; // Replace 'field_name' with the name of the field you want to retrieve

    if (userTeam != null) {
      // Handle the retrieved field value
      return userTeam;
    } else {
      print('Field not found or is null');
      return "You aren't part of a team";
    }
  } else {
    return "You aren't part of a team";
  }
}
