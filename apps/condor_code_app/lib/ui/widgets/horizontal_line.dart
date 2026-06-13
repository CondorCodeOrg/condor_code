import 'package:flutter/material.dart';

class HorizontalLine extends StatelessWidget {
  const HorizontalLine({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black,
        ),
        margin: const EdgeInsets.only(top: 50, bottom: 50),
        width: 30,
        height: 5,
        alignment: Alignment.centerLeft,
      ),
      Container(
        margin: const EdgeInsets.only(left: 100, right: 100),
        child: Text(title, style: const TextStyle(fontSize: 15)),
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black,
        ),
        margin: const EdgeInsets.only(top: 50, bottom: 50),
        width: 30,
        height: 5,
      ),
    ],
  );
}
