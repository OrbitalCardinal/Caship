import 'package:flutter/material.dart';

class SquareAvatar extends StatelessWidget {
  final String url;

  SquareAvatar(this.url);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      decoration: BoxDecoration(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image(
          fit: BoxFit.fitWidth,
          image: NetworkImage(url),
        ),
      ),
    );
  }
}
