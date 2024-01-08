import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pokemon_game/buttons.dart';
import 'package:pokemon_game/characters/pj.dart';
import 'package:pokemon_game/maps/pallettown.dart';
import 'package:pokemon_game/maps/pokelab.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset('lib/images/splashpoke.png'),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double mapX = 0;
  double mapY = 0;
  double labMapX = 0;
  double labMapY = 0;

  String oakDirection = 'Down';

  bool chatStarted = false;
  int countPressingA = -1;
  int boySpriteCount = 0;
  String boyDirection = 'Down';
  String currentLocation = 'pallettown';
  double step = 0.15;

  List<List<double>> noMansLandLab = [
    [0.15, -2.85],
    [0.30, -2.85],
    [0.45, -2.85],
    [0.6, -2.85],
    [0.75, -2.85],
    [0.90, -2.85],
    [1.05, -2.85],
    [1.20, -2.85],
    [1.35, -2.85],
    [1.50, -2.85],
    [1.65, -2.85],
    [1.80, -2.85],
    [1.95, -2.85],
    [2.10, -2.85],
    [2.25, -2.85],
    [2.40, -2.85],
    [2.40, -2.70],
    [2.40, -2.55],
    [2.40, -2.40],
    [2.40, -2.25],
    [2.40, -2.10],
    [2.85, -1.95],
    [2.85, -1.80],
    [2.85, -1.65],
    [2.85, -1.50],
    [2.85, -1.35],
    [2.70, -1.20],
    [2.55, -1.20],
    [2.40, -1.20],
    [2.25, -1.20],
    [2.10, -1.20],
    [1.95, -1.20],
    [1.80, -1.20],
    [1.65, -1.20],
    [1.50, -1.20],
    [1.35, -1.20],
    [1.20, -1.20],
    [1.05, -1.20],
    [0.90, -1.20],
    [0.75, -1.20],
    [0.60, -1.20],
    [0.45, -1.20],
    [0.45, -1.05],
    [0.45, -0.90],
    [0.45, -0.75],
    [0.45, -0.60],
    [0.45, -0.45],
    [0.45, -0.30],
    [2.85, -0.15],
    [2.85, 0.0],
    [2.85, 0.15],
    [2.85, 0.30],
    [2.70, 0.45],
    [2.55, 0.45],
    [2.40, 0.45],
    [2.25, 0.45],
    [2.10, 0.45],
    [1.95, 0.45],
    [1.80, 0.45],
    [1.65, 0.45],
    [1.50, 0.45],
    [1.50, 0.60],
    [1.50, 0.75],
    [1.50, 0.90],
    [1.50, 1.05],
    [1.50, 1.20],
    [1.50, 1.35],
    [1.50, 1.50],
    [1.50, 1.65],
    [1.50, 1.80],
    [1.50, 1.95],
    [1.50, 2.05],
    [1.35, 2.10],
    [1.20, 2.10],
    [1.05, 2.10],
    [0.90, 2.10],
    [0.75, 2.10],
    [0.60, 2.10],
    [0.45, 2.10],
    [0.30, 1.95],
    [0.30, 1.80],
    [0.30, 1.65],
    [0.30, 1.50],
    [0.15, 1.35],
    [0.0, 1.35],
    [-0.15, 1.20],
    [-0.30, 1.20],
    [-0.45, 1.05],
    [-0.45, 0.90],
    [-0.45, 0.75],
    [-0.45, 0.60],
    [-0.45, 0.45],
    [-0.45, 0.30],
    [-0.45, 0.15],
    [-0.45, 0.0],
    [-0.45, -0.15],
    [-0.45, -0.30],
    [-0.45, -0.45],
    [-0.45, -0.60],
    [-0.45, -0.75],
    [-0.45, -0.90],
    [-0.45, -1.05],
    [-0.45, -1.20],
    [-0.45, -1.35],
    [-0.45, -1.50],
    [-0.45, -1.65],
    [-0.45, -1.80],
    [-0.45, -1.95],
    [-0.45, -2.10],
    [-0.45, -2.25],
    [-0.45, -2.40],
    [-0.45, -2.55],
    [-0.45, -2.70],
    [-0.45, -2.85],
    [-0.30, -2.85],
    [-0.15, -2.85],
  ];

  List<List<double>> noMansLandPalletTown = [
    [2.3999999999999995, 0.0],
    [2.3999999999999996, 0.15],
    [2.3999999999999996, 0.30],
    [2.3999999999999996, 0.45],
    [2.3999999999999996, 0.60],
    [2.3999999999999996, 0.75],
    [2.3999999999999996, 0.90],
    [2.3999999999999996, 1.05],
    [2.3999999999999996, 1.20],
    [2.3999999999999996, 1.35],
    [2.3999999999999996, 1.50],
    [2.3999999999999995, 0.0],
    [2.3999999999999996, -0.15],
    [2.3999999999999996, -0.30],
    [2.3999999999999996, -0.45],
    [2.3999999999999996, -0.60],
    [2.3999999999999996, -0.75],
    [2.3999999999999996, -0.90],
    [2.3999999999999996, -1.05],
    [2.3999999999999996, -1.20],
    [2.3999999999999996, -1.35],
    [2.2499999999999996, -1.50],
    [2.0999999999999996, -1.50],
    [1.9499999999999997, -1.50],
    [1.7999999999999998, -1.50],
    [1.65, -1.50],
    [1.50, -1.50],
    [1.35, -1.50],
    [1.35, -1.3499999999999999],
    [1.35, -1.2],
    [1.2, -1.05],
    [1.05, -1.05],
    [0.9, -1.05],
    [0.75, -1.05],
    [0.60, -1.05],
    [0.45, -1.05],
    [0.30, -1.05],
    [0.14999999999999994, -1.4999999999999998],
    [0.0, -1.4999999999999998],
    [-0.15, -1.4999999999999998],
    [-0.30, -1.4999999999999998],
    [-0.45, -1.4999999999999998],
    [-0.60, -1.4999999999999998],
    [-0.75, -1.4999999999999998],
    [-0.90, -1.4999999999999998],
    [-1.05, -1.4999999999999998],
    [-1.20, -1.4999999999999998],
    [-1.35, -1.4999999999999998],
    [-1.50, -1.4999999999999998],
    [-1.65, -1.4999999999999998],
    [-1.80, -1.4999999999999998],
    [-1.95, -1.4999999999999998],
    [-2.10, -1.4999999999999998],
    [-2.25, -1.4999999999999998],
    [-2.40, -1.4999999999999998],
    [-2.40, -1.34999999999999998],
    [-2.40, -1.2],
    [-2.40, -1.05],
    [-2.40, -0.9],
    [-2.40, -0.75],
    [-2.40, -0.6],
    [-2.40, -0.45],
    [-2.40, -0.30],
    [-2.40, -0.15],
    [-2.40, 0.0],
    [-2.40, 0.15],
    [-2.40, 0.30],
    [-2.40, 0.45],
    [-2.40, 0.60],
    [-2.40, 0.75],
    [-2.40, 0.90],
    [-2.40, 1.05],
    [-2.40, 1.20],
    [-2.2499999999999996, 1.3499999999999999],
    [-2.0999999999999996, 1.3499999999999999],
    [-1.9499999999999997, 1.3499999999999999],
    [-1.7999999999999998, 1.3499999999999999],
    [-1.65, 1.3499999999999999],
    [-1.50, 1.3499999999999999],
    [-1.35, 1.3499999999999999],
    [-1.20, 1.3499999999999999],
    [-1.05, 1.3499999999999999],
    [-0.90, 1.3499999999999999],
    [-0.75, 1.3499999999999999],
    [-0.60, 1.3499999999999999],
    [-0.45, 1.3499999999999999],
    [-0.30, 1.3499999999999999],
    [-0.15, 1.3499999999999999],
    [0.0, 1.3499999999999999],
    [0.15, 1.3499999999999999],
    [0.30, 1.3499999999999999],
    [0.45, 1.3499999999999999],
    [0.60, 1.3499999999999999],
    [0.75, 1.3499999999999999],
    [0.90, 1.3499999999999999],
    [1.05, 1.3499999999999999],
    [1.20, 1.3499999999999999],
    [1.35, 1.3499999999999999],
    [1.50, 1.3499999999999999],
    [1.65, 1.3499999999999999],
    [1.80, 1.3499999999999999],
    [1.95, 1.3499999999999999],
    [2.10, 1.3499999999999999],
    [2.25, 1.3499999999999999],
    [2.40, 1.3499999999999999],
    [0.30, 0.44999999999999996],
    [0.30, 0.6],
    [0.30, 0.75],
    [0.30, 0.90],
    [0.30, 1.05],
    [1.6499999999999997, 1.05],
    [1.4999999999999998, 1.05],
    [1.3499999999999999, 1.05],
    [1.35, 1.05],
    [1.2, 1.05],
    [1.05, 1.05],
    [0.9, 1.05],
    [0.75, 1.05],
    [0.60, 1.05],
    [0.45, 1.05],
    [-0.15, 0.15],
    [-0.15, 0.0],
    [-0.15, -0.15],
    [-0.15, -0.30],
    [-0.15, -0.45],
    [-0.15, -0.60],
    [-2.0999999999999996, 0.15],
    [-2.0999999999999996, 0.0],
    [-2.0999999999999996, -0.15],
    [-2.0999999999999996, -0.30],
    [-2.0999999999999996, -0.44999999999999996],
    [-2.0999999999999996, -0.60],
    [-0.29999999999999993, -0.6],
    [-0.44999999999999996, -0.6],
    [-0.6, -0.6],
    [-0.75, -0.6],
    [-0.90, -0.6],
    [-1.05, -0.6],
    [-1.35, -0.6],
    [-1.50, -0.6],
    [-1.65, -0.6],
    [-1.80, -0.6],
    [-1.95, -0.6],
    [0.45, 0.45],
    [0.6, 0.45],
    [0.75, 0.45],
    [0.90, 0.45],
    [1.05, 0.45],
    [1.20, 0.45],
    [1.35, 0.45],
    [1.50, 0.45],
    [1.65, 0.45],
    [1.80, 0.45],
    [1.95, 0.45],
    [2.10, 0.45],
    [2.10, 0.60],
    [1.95, 0.60],
    [1.80, 0.75],
    [1.80, 0.90],
    [1.80, 1.05],
    [-1.95, 0.15],
    [-1.8, 0.15],
    [-1.65, 0.15],
    [-1.50, 0.15],
    [-1.35, 0.15],
    [-1.20, 0.15],
    [-1.05, 0.15],
    [-0.90, 0.15],
    [-0.75, 0.15],
    [-0.60, 0.15],
    [-0.45, 0.15],
    [-0.30, 0.15],
    [-0.30, -1.05],
    [-0.45, -1.05],
    [-0.6, -1.05],
    [-0.75, -1.05],
    [-0.90, -1.05],
    [-1.05, -1.05],
    [-1.20, -1.05],
    [-1.35, -1.05],
    [-1.50, -1.05],
    [-1.65, -1.05],
    [0.6, -0.30],
    [0.75, -0.30],
    [0.90, -0.30],
    [1.05, -0.30],
    [1.20, -0.30],
    [1.35, -0.30],
    [1.50, -0.30],
    [1.65, -0.30],
    [1.80, -0.30],
    [-0.15, 0.45],
    [-0.15, 0.60],
    [-0.45, 0.75],
    [-0.45, 0.9],
    [-0.45, 1.05],
    [-0.60, 1.05],
    [-0.75, 1.05],
    [-0.90, 1.05],
    [-1.05, 1.05],
    [-1.20, 1.05],
    [-1.35, 1.05],
    [-1.50, 1.05],
    [-1.65, 1.05],
    [-1.80, 1.05],
    [-1.80, 0.9],
    [-1.80, 0.75],
    [-1.80, 0.60],
    [-1.80, 0.45],
    [-1.65, 0.45],
    [-1.50, 0.45],
    [-1.35, 0.45],
    [-1.20, 0.45],
    [-1.05, 0.45],
    [-0.90, 0.45],
    [-0.75, 0.45],
    [-0.60, 0.45],
    [-0.45, 0.45],
    [-0.30, 0.45],
  ];

  void moveUp() {
    boyDirection = 'Up';
    if (currentLocation == 'pallettown') {
      if (canMoveTo(boyDirection, noMansLandPalletTown, mapX, mapY)) {
        setState(() {
          mapY += step;
        });
      }
      if (double.parse((mapX).toStringAsFixed(4)) == -1.20 &&
          double.parse((mapY).toStringAsFixed(4)) == -0.6) {
        setState(() {
          currentLocation = 'pokelab';
          labMapX = 0;
          labMapY = -2.4;
        });
        animateWalk();
        return;
      }
      animateWalk();
    } else if (currentLocation == 'pokelab') {
      if (canMoveTo(boyDirection, noMansLandLab, labMapX, labMapY)) {
        setState(() {
          labMapY += step;
        });
      }
      animateWalk();
    }
  }

  void moveDown() {
    boyDirection = 'Down';
    if (currentLocation == 'pallettown') {
      if (canMoveTo(boyDirection, noMansLandPalletTown, mapX, mapY)) {
        setState(() {
          mapY -= step;
        });
      }

      animateWalk();
    } else if (currentLocation == 'pokelab') {
      if (canMoveTo(boyDirection, noMansLandLab, labMapX, labMapY)) {
        setState(() {
          labMapY -= step;
        });
      }
      if (double.parse((labMapX).toStringAsFixed(4)) == 0 &&
          double.parse((labMapY).toStringAsFixed(4)) == -2.85) {
        setState(() {
          currentLocation = 'pallettown';
          mapX = -1.20;
          mapY = -0.6;
        });
        animateWalk();
        return;
      }
      animateWalk();
    }
  }

  void moveLeft() {
    boyDirection = 'Left';
    if (currentLocation == 'pallettown') {
      if (canMoveTo(boyDirection, noMansLandPalletTown, mapX, mapY)) {
        setState(() {
          mapX += step;
        });
      }
      animateWalk();
    } else if (currentLocation == 'pokelab') {
      if (canMoveTo(boyDirection, noMansLandLab, labMapX, labMapY)) {
        setState(() {
          labMapX += step;
        });
      }
      animateWalk();
    }
  }

  void moveRight() {
    boyDirection = 'Right';
    if (currentLocation == 'pallettown') {
      if (canMoveTo(boyDirection, noMansLandPalletTown, mapX, mapY)) {
        setState(() {
          mapX -= step;
        });
      }
      animateWalk();
    } else if (currentLocation == 'pokelab') {
      if (canMoveTo(boyDirection, noMansLandLab, labMapX, labMapY)) {
        setState(() {
          labMapX -= step;
        });
      }
      animateWalk();
    }
  }

  void pressedA() {
    showPokemonDateTimeDialog();
  }

  void showPokemonDateTimeDialog() {
    DateTime now = DateTime.now();
    String formattedDate = "${now.day}-${now.month}-${now.year}";
    String formattedTime = "${now.hour}:${now.minute}:${now.second}";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 231, 240, 255),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Text(
            'PokéHora',
            style: TextStyle(
              color: Color.fromARGB(255, 228, 121, 0),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Fecha: $formattedDate',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              Text(
                'Hora: $formattedTime',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cerrar',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 240, 17, 1),
                  fontSize: 16,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  LinearGradient createGradient() {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Colors.blue, Colors.green],
    );
  }

  void pressedB() async {
    // URL base de la API de PokeAPI para obtener la lista completa de Pokémon
    const String apiUrl = 'https://pokeapi.co/api/v2/pokemon/';
    final List<String> pokemonNames = [];

    // Función para obtener los nombres de los Pokémon de una página específica
    Future<void> fetchPage(String url) async {
      final http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> responseData =
            json.decode(response.body)['results'];
        pokemonNames.addAll(responseData.map<String>((result) {
          return capitalize(result['name']);
        }));
      } else {
        // Manejar errores de la API
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Error',
                style: TextStyle(color: Colors.red),
              ),
              content: Text('No se pudo obtener la lista de Pokémon.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cerrar',
                    style: TextStyle(
                        fontWeight: FontWeight.w800, color: Colors.red),
                  ),
                ),
              ],
            );
          },
        );
      }
    }

    for (int i = 1; i <= 4; i++) {
      await fetchPage('$apiUrl?offset=${(i - 1) * 25}&limit=25');
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Lista de Pokémons',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Color.fromARGB(255, 165, 204, 236),
          content: Container(
            width: double.maxFinite,
            height: 400,
            decoration: BoxDecoration(
              color: Color.fromARGB(221, 121, 133, 143),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 165, 204, 236),
                  Color.fromARGB(255, 165, 204, 236),
                ],
              ),
            ),
            child: ListView.builder(
              itemCount: pokemonNames.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  color: Color.fromARGB(200, 135, 193, 240),
                  elevation: 5,
                  margin:
                      EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
                  child: ListTile(
                    title: Text(
                      pokemonNames[index],
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    leading: Image.asset(
                      'lib/images/pokebal.png',
                      width: 32,
                      height: 32,
                    ),
                    onTap: () {
                      showPokemonDetails(context, pokemonNames[index]);
                    },
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cerrar',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.red,
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void showPokemonDetails(BuildContext context, pokemonName) async {
    final String lowercasePokemonName = pokemonName.toLowerCase();
    final String apiUrl =
        'https://pokeapi.co/api/v2/pokemon/$lowercasePokemonName';

    final http.Response response = await http.get(Uri.parse(apiUrl));
    final Map<String, String> tiposTraducidos = {
      'normal': 'Normal',
      'fighting': 'Lucha',
      'flying': 'Volador',
      'poison': 'Veneno',
      'ground': 'Tierra',
      'rock': 'Roca',
      'bug': 'Bicho',
      'ghost': 'Fantasma',
      'steel': 'Acero',
      'fire': 'Fuego',
      'water': 'Agua',
      'grass': 'Planta',
      'electric': 'Eléctrico',
      'psychic': 'Psíquico',
      'ice': 'Hielo',
      'dragon': 'Dragón',
      'dark': 'Siniestro',
      'fairy': 'Hada',
    };
    if (response.statusCode == 200) {
      final Map<String, dynamic> pokemonData = json.decode(response.body);

      String imageUrl = pokemonData['sprites']['front_default'];
      List<String> types = pokemonData['types'].map<String>((type) {
        return capitalize(tiposTraducidos[type['type']['name']]!);
      }).toList();

      Color
          containerBackgroundColor; // Variable para almacenar el color de fondo del Container interno

      // Obtener el color correspondiente al tipo del Pokémon
      if (types.contains('Planta')) {
        containerBackgroundColor = const Color.fromARGB(
            255, 152, 194, 103); // Verde muy clarito para tipo planta
      } else if (types.contains('Agua') || types.contains('Hielo')) {
        containerBackgroundColor =
            Colors.lightBlueAccent; // Azul muy clarito para tipo agua e hielo
      } else if (types.contains('Fuego')) {
        containerBackgroundColor = const Color.fromARGB(
            255, 236, 112, 103); // Rojo muy clarito para tipo fuego
      } else if (types.contains('Volador') || types.contains('Roca')) {
        containerBackgroundColor = const Color.fromARGB(
            255, 153, 113, 98); // Marrón muy clarito para tipo volador y roca
      } else if (types.contains('Acero')) {
        containerBackgroundColor =
            Colors.grey[300]!; // Gris muy clarito para tipo acero
      } else if (types.contains('Eléctrico')) {
        containerBackgroundColor = const Color.fromARGB(255, 218, 202, 59);
      } else if (types.contains('Veneno')) {
        containerBackgroundColor = Color.fromARGB(
            255, 164, 99, 177); // Amarillo muy clarito para tipo eléctrico
      } else if (types.contains('Siniestro')) {
        containerBackgroundColor = Colors.black54;
      } else if (types.contains('Bicho')) {
        containerBackgroundColor = Color.fromARGB(255, 86, 126, 111);
      } else if (types.contains('Normal')) {
        containerBackgroundColor = Color.fromARGB(
            255, 221, 191, 181); // Negro muy clarito para tipo siniestro
      } else {
        containerBackgroundColor = Colors
            .lightBlue; // Color predeterminado si no coincide con ninguno de los anteriores
      }

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color.fromARGB(248, 80, 78,
                78), // Establecer el fondo del AlertDialog como transparente
            title: Text(
              capitalize(pokemonName),
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            content: Container(
              decoration: BoxDecoration(
                color: containerBackgroundColor,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: const Color.fromARGB(255, 52, 64, 75),
                  width: 2.0,
                ),
              ),
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.network(
                      imageUrl,
                      width: 120,
                      height: 120,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Número: ${pokemonData['id']}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.white),
                  ),
                  Text(
                    'Altura: ${pokemonData['height']} m',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.white),
                  ),
                  Text(
                    'Peso: ${pokemonData['weight']} kg',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.white),
                  ),
                  Text(
                    'Tipos: ${types.join(', ')}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Cerrar',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.red,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(
                'No se pudieron obtener los detalles del Pokémon $pokemonName.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  String capitalize(String s) {
    return s[0].toUpperCase() + s.substring(1);
  }

  void animateWalk() {
    print('x: ' + labMapX.toString() + ', y: ' + labMapY.toString());
    Timer.periodic(Duration(milliseconds: 20), (timer) {
      setState(() {
        boySpriteCount++;
      });

      if (boySpriteCount == 3) {
        boySpriteCount = 0;
        timer.cancel();
      }
    });
  }

  double cleanNum(double num) {
    return double.parse(num.toStringAsFixed(4));
  }

  bool canMoveTo(String direction, var noMansLand, double x, double y) {
    double stepX = 0;
    double stepY = 0;

    if (direction == 'Left') {
      stepX = step;
      stepY = 0;
    } else if (direction == 'Right') {
      stepX = -step;
      stepY = 0;
    } else if (direction == 'Up') {
      stepX = 0;
      stepY = step;
    } else if (direction == 'Down') {
      stepX = 0;
      stepY = -step;
    }

    for (int i = 0; i < noMansLand.length; i++) {
      if ((cleanNum(noMansLand[i][0]) == cleanNum(x + stepX)) &&
          (cleanNum(noMansLand[i][1]) == cleanNum(y + stepY))) {
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              color: Colors.black,
              child: Stack(
                children: [
                  PalletTown(
                    x: mapX,
                    y: mapY,
                    currentMap: currentLocation,
                  ),
                  Pokelab(x: labMapX, y: labMapY, currentMap: currentLocation),
                  Container(
                    alignment: Alignment(0, 0),
                    child: MyPj(
                      location: currentLocation,
                      boySpriteCount: boySpriteCount,
                      direction: boyDirection,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Color.fromARGB(255, 31, 32, 32),
              child: Padding(
                padding: const EdgeInsets.all(21.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.white10,
                            border: Border.all(
                              color: Colors.red,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: const Text(
                            'N I N T E N D O',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 8.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                ),
                                MyButton(
                                  text: '￩',
                                  function: moveLeft,
                                ),
                                Container(
                                  height: 50,
                                  width: 50,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                MyButton(
                                  text: '↑',
                                  function: moveUp,
                                ),
                                Container(
                                  height: 50,
                                  width: 50,
                                ),
                                MyButton(
                                  text: '↓',
                                  function: moveDown,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                ),
                                MyButton(
                                  text: '￫',
                                  function: moveRight,
                                ),
                                Container(
                                  height: 50,
                                  width: 50,
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                MyButton(
                                  text: 'a',
                                  function: pressedA,
                                ),
                                Container(
                                  width: 50,
                                  height: 50,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                ),
                                MyButton(
                                  text: 'b',
                                  function: pressedB,
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    const Text(
                      'H I B E R U S',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
