import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SecondSlideScreen extends StatelessWidget {
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
                        'assets/imgs/Second.png',
                      ),
                      height: 300,
                    ),
                    Column(
                      children: [
                        Text(
                          AppLocalizations.of(context).slide2Title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(
                          AppLocalizations.of(context).slide2Legend,
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
