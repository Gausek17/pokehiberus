import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Oak extends StatelessWidget {
  double x;
  double y;
  String location;
  String oakDirection;

  Oak({
    required this.x,
    required this.y,
    required this.location,
    required this.oakDirection,
  });

  @override
  Widget build(BuildContext context) {
    if (location == 'pokelab') {
      return Container(
        alignment: Alignment(x, y),
        child: Image.asset(
          'lib/images/profesorOakfront.png',
          width: MediaQuery.of(context).size.width * 0.05,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return Container();
    }
  }
}
