import 'package:flutter/material.dart';

const Color black = Color.fromARGB(255, 39, 40, 43);
const Color blue = Colors.blue;
const Color grey = Color.fromARGB(255, 234, 243, 255);
const Color shadowColor = Color.fromARGB(52, 45, 47, 49);

Widget CustomScroller({required Widget child}) {
  return CustomScrollView(
    slivers: [
      SliverFillRemaining(
        hasScrollBody: false,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                child: child,
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
