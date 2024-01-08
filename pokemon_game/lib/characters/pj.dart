import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyPj extends StatelessWidget {
  final int boySpriteCount;
  final String direction;
  final String location;
  double height = 20;

  MyPj(
      {required this.boySpriteCount,
      required this.direction,
      required this.location});

  @override
  Widget build(BuildContext context) {
    if (location == 'pallettown') {
      height = 20;
    } else if (location == 'pokelab') {
      height = 30;
    } else if (location == 'battleground' ||
        location == 'attackoptions' ||
        location == 'battlefinishedscreen') {
      height = 0;
    }

    return Container(
      height: height,
      child: Image.asset(
        'lib/images/boy' + direction + boySpriteCount.toString() + '.png',
        fit: BoxFit.cover,
      ),
    );
  }
}
