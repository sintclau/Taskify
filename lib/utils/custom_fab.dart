import 'dart:math';
import 'package:flutter/material.dart';
import 'package:side_sheet/side_sheet.dart';

final double buttonSize = 70;

class CustomFab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CustomFabState();
}

class _CustomFabState extends State<CustomFab>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

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
          backgroundColor: Color.fromARGB(255, 19, 146, 186),
          shape: OvalBorder(),
          child: Icon(
            icon,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            if (icon == Icons.task) {
              SideSheet.right(
                context: context,
                width: MediaQuery.of(context).size.width * 0.3,
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "New task",
                      style: TextStyle(color: Colors.white, fontSize: 35),
                    ),
                  ],
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
