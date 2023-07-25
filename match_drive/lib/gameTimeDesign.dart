import 'package:flutter/material.dart';

class CarInfo {
  final String model;
  final String color;

  CarInfo({required this.model, required this.color});
}

class GameTime extends StatefulWidget {
  const GameTime({Key? key}) : super(key: key);

  @override
  State<GameTime> createState() => _GameTimeState();
}

class _GameTimeState extends State<GameTime> {
  int value = 0;
  int firstCardIndex = -1;
  int secondCardIndex = -1;

  List<String> imagePaths = [
    'assets/images/images1.jpg',
    'assets/images/images2.jpg',
  ];

  List<CarInfo> carInfos = [
    CarInfo(model: 'Audi A8', color: 'Siyah'),
    CarInfo(model: 'BMW 3 Serisi', color: 'Beyaz'),
  ];

  List<bool> isBoxOpen = List.generate(12, (index) => false);

  void _toggleBoxState(int index) {
    setState(() {
      if (firstCardIndex == -1) {
        firstCardIndex = index;
        isBoxOpen[index] = true;
      } else if (secondCardIndex == -1) {
        secondCardIndex = index;
        isBoxOpen[index] = true;

        // Check if the opened cards match
        CarInfo firstCard = carInfos[firstCardIndex % carInfos.length];
        CarInfo secondCard = carInfos[secondCardIndex % carInfos.length];
        bool isMatch = firstCard.model == secondCard.model &&
            firstCard.color == secondCard.color;

        // Delay for a short duration to show the second card before hiding
        Future.delayed(Duration(milliseconds: 500), () {
          setState(() {
            if (isMatch) {
              value++; // Increment score if cards match
              isBoxOpen[firstCardIndex] = false; // Hide the matching cards
              isBoxOpen[secondCardIndex] = false;
            } else {
              // If cards don't match, close them again
              isBoxOpen[firstCardIndex] = false;
              isBoxOpen[secondCardIndex] = false;
            }

            // Reset the opened card indices after handling the match
            firstCardIndex = -1;
            secondCardIndex = -1;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
                child: Icon(
                  Icons.gamepad,
                  color: Colors.yellow,
                ),
              ),
              Expanded(
                child: Text(
                  'Match Drive',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 50, 0),
                child: Icon(
                  Icons.gamepad,
                  color: Colors.yellow,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        color: Colors.white,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 0.45,
          ),
          itemCount: 12,
          itemBuilder: (BuildContext context, int index) {
            CarInfo carInfo = carInfos[index % carInfos.length];

            if (isBoxOpen[index]) {
              return GestureDetector(
                onTap: () {
                  _toggleBoxState(index);
                },
                child: Container(
                  color: Colors.black,
                  margin: const EdgeInsets.fromLTRB(10, 30, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(imagePaths[index % imagePaths.length]),
                      Text(
                        'Araba Modeli: ${carInfo.model}',
                        style: const TextStyle(color: Colors.yellow),
                      ),
                      Text(
                        'Araba Rengi: ${carInfo.color}',
                        style: const TextStyle(color: Colors.yellow),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return GestureDetector(
                onTap: () {
                  _toggleBoxState(index);
                },
                child: Container(
                  color: Colors.black,
                  margin: const EdgeInsets.fromLTRB(10, 30, 0, 0),
                  child: Center(
                    child: Text(
                      (index + 1).toString(),
                      style: const TextStyle(color: Colors.yellow),
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            value = 0;
            setState(() {});
          },
          backgroundColor: Colors.black,
          child:
              const Icon(Icons.change_circle_outlined, color: Colors.yellow)),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(20),
        color: Colors.black,
        height: 50,
        child: Center(
          child: Text('Score : $value', style: TextStyle(color: Colors.yellow)),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: GameTime(),
  ));
}
