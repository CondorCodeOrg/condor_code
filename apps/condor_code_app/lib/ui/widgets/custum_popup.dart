import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class CustomPopup extends StatelessWidget {
  const CustomPopup({super.key, required this.showPopup});

  final bool showPopup;

  @override
  Widget build(BuildContext context) {
    List<Image> images = [];

    List<Image> showHeartImages() {
      for (var i = 0; i < 5; i++) {
        images = [
          ...images,
          Image.asset('assets/images/heart.webp', width: 50),
        ];
      }
      return images;
    }

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 500),
      top: showPopup ? 0 : -300,
      width: 412,
      height: 300,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: showHeartImages(),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Text(
                'Ваш запас жизней полон',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: context.colors.textPrimary,
                ),
              ),
            ),
            const TaskButton(),
            const TaskButton(),
            const TaskButton(),
          ],
        ),
      ),
    );
  }
}

class TaskButton extends StatelessWidget {
  const TaskButton({super.key});

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        width: 380,
        height: 50,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 12, 224, 243),
              Color.fromARGB(255, 7, 78, 231),
              Color.fromARGB(255, 178, 17, 242),
            ],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(Icons.abc, color: context.colors.textPrimary),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Бесконечные',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: context.colors.textPrimary,
                      ),
                    ),
                    Text(
                      'жизни',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: context.colors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Пробная',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: context.colors.textPrimary,
                  ),
                ),
                Text(
                  'версия',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: context.colors.textPrimary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}
