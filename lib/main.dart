import 'package:flutter/material.dart';

import 'appBar.dart';
import 'data/CommonData.dart';
import 'navs.dart';

import 'package:flutter/gestures.dart';

void main() {
  runApp(const MyApp());
}

class WebScroll extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices {
    return {
      PointerDeviceKind.touch,
      PointerDeviceKind.mouse,
    };
  }
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
  CommonData? _commonData = null;

  @override
  Widget build(BuildContext context) {
    const Widget logo = Image(
        image: AssetImage('assets/images/logo.png'),
        alignment: Alignment.center);

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
        body: makeNav(
          context,
          _commonData,
          _selectedDestination,
        ),
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          child: NavigationBar(
            onDestinationSelected: onDestinationSelected,
            selectedIndex: _selectedDestination,
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            destinations: <Widget>[
              NavigationDestination(
                selectedIcon: Icon(Icons.home),
                icon: Icon(Icons.home_outlined),
                label: 'Strona główna',
              ),
              Text(''),
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
