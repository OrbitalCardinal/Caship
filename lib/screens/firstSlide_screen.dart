import 'package:flutter/material.dart';

class FirstSlideScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Expanded(
          flex: 4,
          child: Container(
            // color: Colors.red,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image(
                      image: AssetImage(
                        'assets/imgs/First.png',
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Presta sin preocuparte",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(
                          "Caship ayuda a la gente a prestar dinero, administrar los tiempos e intereses.",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
