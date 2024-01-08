import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class PalletTown extends StatefulWidget {
  double x;
  double y;
  String currentMap;

  PalletTown({required this.x, required this.y, required this.currentMap});

  @override
  _PalletTownState createState() => _PalletTownState();
}

class _PalletTownState extends State<PalletTown> {
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _playBackgroundMusic();
  }

  void _playBackgroundMusic() async {
    final player = AudioPlayer();
    await player.play(AssetSource('sounds/pokecut.wav'));
  }

  @override
  Widget build(BuildContext context) {
    if (widget.currentMap == 'pallettown') {
      return Container(
        alignment: Alignment(widget.x, widget.y),
        child: Stack(
          children: [
            Image.asset(
              'lib/images/pallettown.png',
              width: MediaQuery.of(context).size.width * 0.75,
              fit: BoxFit.cover,
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
