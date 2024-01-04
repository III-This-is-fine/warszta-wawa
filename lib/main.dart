import 'dart:math';

import 'package:flutter/material.dart';

import 'WebScroll.dart';
import 'appBar.dart';
import 'home/smallMap.dart';
import 'home/types.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 98E55A
    var primary = const Color.fromARGB(255, 0x98, 0xE5, 0x5A);
    // 5A98E5
    var secondary = const Color.fromARGB(255, 0x5A, 0x98, 0xE5);
    // 615AE5
    var tertiary = const Color.fromARGB(255, 0x61, 0x5A, 0xE5);

    return MaterialApp(
      title: 'Warszta Wawa',
      scrollBehavior: WebScroll(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: primary,
            primary: primary,
            secondary: secondary,
            tertiary: tertiary),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Warszta Wawa'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedDestination = 0;
  double _fab_size = 100.0;

  @override
  Widget build(BuildContext context) {
    const Widget logo = Image(
        image: AssetImage('assets/images/logo.png'),
        alignment: Alignment.center);

    const categories = [
      (Icons.sports_volleyball_outlined, 'Sportowe'),
      (Icons.palette_outlined, 'Artystyczne'),
      (Icons.school_outlined, 'Naukowe'),
      (Icons.music_note_outlined, 'Muzyczne'),
      (Icons.chat_bubble_outline_outlined, 'Językowe'),
      (Icons.fitness_center_outlined, 'Fitness'),
      (Icons.accessibility_new_outlined, 'Taniec'),
      (Icons.local_library_outlined, 'Inne'),
    ];

    const N = 100;
    const latMin = 52.1348782;
    const latMax = 52.3219161;
    const lonMin = 20.8023824;
    const lonMax = 21.2087757;

    var rng = new Random();
    var markers = List.generate(
        N,
        (i) => (
              rng.nextDouble() * (latMax - latMin) + latMin,
              rng.nextDouble() * (lonMax - lonMin) + lonMin
            ));

    var subtitle = (String text) => Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          //apply padding to all four sides
          child: Text(
            text,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
        );

    void onDestinationSelected(int index) {
      setState(() {
        _selectedDestination = index;
        if (_selectedDestination == 1) {
          _fab_size = 130.0;
        } else {
          _fab_size = 100.0;
        }
      });
    }

    const animationDuration = Duration(milliseconds: 250);
    const animationCurve = Curves.easeInOut;

    return Scaffold(
        appBar: appBar(logo),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              subtitle('Typy zajęć'),
              types(categories),
              subtitle('Mapa'),
              makeMap(context, markers),
              SizedBox(height: 100),
              // Tricky way to add padding to the bottom, so that the bottom navigation bar doesn't cover the content
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          child: NavigationBar(
            onDestinationSelected: onDestinationSelected,
            selectedIndex: _selectedDestination,
            destinations: <Widget>[
              NavigationDestination(
                selectedIcon: Icon(Icons.home),
                icon: Icon(Icons.home_outlined),
                label: 'Strona główna',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.error, color: Colors.transparent),
                icon: Icon(Icons.error, color: Colors.transparent),
                label: '',
              ),
              NavigationDestination(
                icon: Icon(Icons.pin_drop_outlined),
                label: 'Mapa',
              ),
            ],
          ),
        ),
        extendBody: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: GestureDetector(
          onTap: () {
            onDestinationSelected(1);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiary,
              borderRadius: BorderRadius.circular(100),
            ),
            child: AnimatedSize(
              curve: animationCurve,
              duration: animationDuration,
              child: AnimatedContainer(
                duration: animationDuration,
                curve: animationCurve,
                width: _fab_size,
                height: _fab_size,
                child: Icon(Icons.search, color: Colors.white, size: 50),
              ),
            ),
          ),
        ));
  }
}
