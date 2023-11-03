import "dart:math";

import "package:flutter/material.dart";

class ProjectCard extends StatelessWidget {
  final Color gradientColor1, gradientColor2;
  final String title;
  final double progress;

  ProjectCard(
      this.gradientColor1, this.gradientColor2, this.title, this.progress);

  String splitTitle(String title, int maxWords) {
    List<String> words = title.split(' ');
    if (words.length < maxWords) return title;
    return words.take(1).join(' ') + '\n' + words.skip(1).join(' ');
  }

  @override
  Widget build(BuildContext context) {
    final modifiedTitle = splitTitle(title, 3);

    return Container(
      margin: EdgeInsets.only(right: 15),
      height: 140,
      width: 250,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(23),
          gradient: LinearGradient(
              colors: [gradientColor1, gradientColor2],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight)),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, top: 15, right: 20, bottom: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              modifiedTitle,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(color: Colors.white, fontSize: 25, height: 1.25),
            ),
            const SizedBox(height: 2),
            Text(
              "Sat, 22 Nov 2023",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            const SizedBox(height: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(23),
                    ),
                    width: 150,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(23),
                      child: LinearProgressIndicator(
                        color: Colors.white,
                        value: progress,
                        minHeight: 7,
                      ),
                    )),
                Text("${(progress * 100).toString()}%",
                    style: TextStyle(color: Colors.white, fontSize: 15))
              ],
            )
          ],
        ),
      ),
    );
  }
}
