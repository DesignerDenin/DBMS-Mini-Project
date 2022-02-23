import 'package:flutter/material.dart';

const Color black = Color.fromARGB(255, 39, 40, 43);
const Color blue = Colors.blue;
const Color grey = Color.fromARGB(255, 234, 243, 255);
const Color shadowColor = Color.fromARGB(52, 45, 47, 49);

Widget CustomScroller({required Widget child, required BuildContext context}) {
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
                child: Container(
                  width: double.infinity,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 100),
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.1,
                      vertical: 80),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 24,
                        color: shadowColor,
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: child,
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
