import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:warszta_wawa/data/Workshops.dart';
import 'package:warszta_wawa/list/filteredList.dart';
import 'appBar.dart';
import 'data/CommonData.dart';
import 'navs.dart';

import 'package:flutter/gestures.dart';

Future<void> main() async {
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
          tertiary: tertiary,
        ),
        fontFamily: GoogleFonts.rubik().fontFamily,
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Warszta Wawa'),
    );
  }
}

var subtitle = (String text) => Padding(
      padding: EdgeInsets.only(left: 15, right: 15),
      //apply padding to all four sides
      child: Text(
        text,
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  int _selectedDestination = 0;
  bool searchAlreadyHit = false;
  bool showListInsteadOfSearch = false;
  Workshops? selectedWorkshop;
  double _fab_size = 100.0;
  CommonData? _commonData = null;
  bool _isBackVisible = false;

  String otherInput = "";
  String district = "";
  String keywords = "";
  Map<String, bool> categoriesSelected = {};
  RangeValues currentAgeRange = const RangeValues(9, 12);
  Map<String, bool> priceSelected = {};
  Map<String, bool> periodSelected = {};
  Map<String, bool> daySelected = {};

  Map<String, AssetImage> imageAssets = {};

  MyHomePageState() {
    cleanSelections();

    imageAssets = Map.fromIterable(
      [
        ('Sportowe'),
        ('Artystyczne'),
        ('Naukowe'),
        ('Muzyczne'),
        ('Językowe'),
        ('Fitness'),
        ('Taniec'),
        ('Inne'),
      ],
      key: (e) => e,
      value: (e) => AssetImage('assets/workshops/$e.png'),
    );
  }

  void cleanSelections() {
    otherInput = "";
    district = "";
    categoriesSelected = {};
    currentAgeRange = const RangeValues(9, 12);
    priceSelected = {
      'Bezpłatne': false,
      'Płatne': false,
    };
    periodSelected = {
      'Cykliczne': false,
      'Jednorazowe': false,
    };
    daySelected = {
      'Poniedziałek': false,
      'Wtorek': false,
      'Środa': false,
      'Czwartek': false,
      'Piątek': false,
      'Sobota': false,
      'Niedziela': false,
    };
  }

  bool anyCategorySelected() {
    return categoriesSelected.values.any((element) => element == true);
  }

  bool anyPriceSelected() {
    return priceSelected.values.any((element) => element == true);
  }

  bool anyPeriodSelected() {
    return periodSelected.values.any((element) => element == true);
  }

  bool anyDaySelected() {
    return daySelected.values.any((element) => element == true);
  }

  bool getCategory(String name) {
    if (categoriesSelected.containsKey(name)) {
      return categoriesSelected[name]!;
    } else {
      return false;
    }
  }

  void setCategory(String name, bool value) {
    categoriesSelected[name] = value;
  }

  bool getPrice(String name) {
    if (priceSelected.containsKey(name)) {
      return priceSelected[name]!;
    } else {
      return false;
    }
  }

  void setPrice(String name, bool value) {
    priceSelected[name] = value;
  }

  void flipPrice(String name) {
    priceSelected[name] = !priceSelected[name]!;
  }

  bool getPeriod(String name) {
    if (periodSelected.containsKey(name)) {
      return periodSelected[name]!;
    } else {
      return false;
    }
  }

  void setPeriod(String name, bool value) {
    periodSelected[name] = value;
  }

  void flipPeriod(String name) {
    periodSelected[name] = !periodSelected[name]!;
  }

  bool getDay(String name) {
    if (daySelected.containsKey(name)) {
      return daySelected[name]!;
    } else {
      return false;
    }
  }

  void setDay(String name, bool value) {
    daySelected[name] = value;
  }

  void flipDay(String name) {
    daySelected[name] = !daySelected[name]!;
  }

  void onDestinationSelected(int index) {
    setState(() {
      _selectedDestination = index;
      if (index == 0) {
        selectedWorkshop = null;
      }

      if (_selectedDestination == 1) {
        _fab_size = 130.0;
      } else {
        _fab_size = 100.0;
      }

      if (_selectedDestination == 0) {
        _isBackVisible = false;
      } else {
        _isBackVisible = true;
      }

      if (searchAlreadyHit) {
        showListInsteadOfSearch = !showListInsteadOfSearch;
      }

      if (_selectedDestination == 1 && searchAlreadyHit == false) {
        searchAlreadyHit = true;
      }
    });
  }

  void setSelectedWorkshop(Workshops workshop) {
    searchAlreadyHit = true;
    onDestinationSelected(1);
    showListInsteadOfSearch = true;
    selectedWorkshop = workshop;
  }

  @override
  Widget build(BuildContext context) {
    const Widget logo = Image(
        image: AssetImage('assets/images/logo.png'),
        alignment: Alignment.center);

    const animationDuration = Duration(milliseconds: 250);
    const animationCurve = Curves.easeInOut;
    _commonData = mockData();

    var filteredWorkshops =
        _commonData!.markers.where((e) => testWorkshop(e, this)).toList();

    return Scaffold(
        appBar: appBar(
          logo,
          _isBackVisible,
          () {
            if (_selectedDestination == 1 &&
                selectedWorkshop != null &&
                searchAlreadyHit &&
                showListInsteadOfSearch) {
              setState(() {
                selectedWorkshop = null;
              });
            } else {
              onDestinationSelected(0);
              selectedWorkshop = null;
              searchAlreadyHit = false;
              showListInsteadOfSearch = false;
            }
          },
          () {},
        ),
        body: makeNav(
          this,
          context,
          _commonData,
          _selectedDestination,
          filteredWorkshops,
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
