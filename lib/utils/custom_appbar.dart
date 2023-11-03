import "package:flutter/material.dart";

class CustomAppBar extends StatelessWidget {
  final double barHeight = 60;

  CustomAppBar();

  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery.of(context).padding.top;

    return Container(
      padding: EdgeInsets.only(top: statusbarHeight),
      height: statusbarHeight + barHeight,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.red, Colors.blue],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(0.5, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: const Padding(
        padding: EdgeInsets.only(left: 32),
        child: Row(
          children: [
            Icon(
              Icons.task,
              size: 30,
              color: Colors.white,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "Taskify",
              style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
