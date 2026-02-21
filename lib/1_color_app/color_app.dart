import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Home()),
    ),
  );
}

enum CardType { red, blue }

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentIndex == 0 ? ColorTapsScreen() : StatisticsScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.tap_and_play),
            label: 'Taps',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statistics',
          ),
        ],
      ),
    );
  }
}

//services
class ColorServiceApp extends ChangeNotifier {
  int _redTapCount = 0;
  int _blueTapCount = 0;

  int get redTapCount => _redTapCount;
  int get blueTapCount => _blueTapCount;

  void incrementRed() {
    _redTapCount++;
    notifyListeners();
  }

  void incrementBlue() {
    _blueTapCount++;
    notifyListeners();
  }
}

//this is global instance
ColorServiceApp colorService = ColorServiceApp();

class ColorTapsScreen extends StatelessWidget {

  const ColorTapsScreen({super.key,});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Color Taps')),
      body: Column(
        children: [
          ColorTap(type: CardType.red),
          ColorTap(type: CardType.blue),
        ],
      ),
    );
  }
}

class ColorTap extends StatelessWidget {
  final CardType type;

  const ColorTap({
    super.key,
    required this.type,
  });

  Color get backgroundColor => type == CardType.red ? Colors.red : Colors.blue;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: colorService, 
      builder: (context, child) {
        int tapCount = type == CardType.red
            ? colorService.redTapCount
            : colorService.blueTapCount;
        return GestureDetector(
          onTap: () {
            if (type == CardType.red) {
              colorService.incrementRed();
            } else {
              colorService.incrementBlue();
            }
          },
          child: Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            width: double.infinity,
            height: 100,
            child: Center(
              child: Text(
                'Taps: $tapCount',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }
}

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Statistics')),
      body: Center(
        child: ListenableBuilder(
          listenable: colorService,
          builder: (context, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Red Taps: ${colorService.redTapCount}',
                  style: TextStyle(fontSize: 24),
                ),
                Text(
                  'Blue Taps: ${colorService.blueTapCount}',
                  style: TextStyle(fontSize: 24),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

//just thinking about bonus 
//service
// class ColorService extends ChangeNotifier {
//   /// Map stores all tap counts
//   final Map<CardType, int> _tapCounts = {
//     for (var type in CardType.values) type: 0,
//   };

//   /// getter
//   int getTapCount(CardType type) {
//     return _tapCounts[type] ?? 0;
//   }

//   /// increment
//   void increment(CardType type) {
//     _tapCounts[type] = (_tapCounts[type] ?? 0) + 1;
//     notifyListeners();
//   }

//   /// getter for all data
//   Map<CardType, int> get tapCounts => _tapCounts;
// }

// /// global instance
// ColorService colorService = ColorService();
