import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:warszta_wawa/WebScroll.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // 98E55A
    var primary = const Color.fromARGB(255, 0x98, 0xE5, 0x5A);
    // 5A98E5
    var secondary = const Color.fromARGB(255, 0x5A, 0x98, 0xE5);
    // 615AE5
    var tertiary = const Color.fromARGB(255, 0x61, 0x5A, 0xE5);

    return MaterialApp(
      title: 'Flutter Demo',
      scrollBehavior: WebScroll(),
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(
            seedColor: primary,
            primary: primary,
            secondary: secondary,
            tertiary: tertiary),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    const Widget logo = Image(image: AssetImage('assets/images/logo.png'));

    const categories = [
      (Icons.sports_volleyball_outlined, 'Sportowe'),
      (Icons.palette_outlined, 'Artystyczne'),
      (Icons.school_outlined, 'Naukowe'),
      (Icons.music_note_outlined, 'Muzyczne'),
      (Icons.chat_bubble_outline_outlined, 'Językowe'),
    ];

    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        // put image as title
        leading: IconButton(
          color: const Color.fromARGB(0, 0, 0, 0),
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: logo,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
            iconSize: 40,
          )
        ],
        toolbarHeight: 80,
      ),
      body: Column(
        // Column is also a layout widget. It takes a list of children and
        // arranges them vertically. By default, it sizes itself to fit its
        // children horizontally, and tries to be as tall as its parent.
        //
        // Column has various properties to control how it sizes itself and
        // how it positions its children. Here we use mainAxisAlignment to
        // center the children vertically; the main axis here is the vertical
        // axis because Columns are vertical (the cross axis would be
        // horizontal).
        //
        // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
        // action in the IDE, or press "p" in the console), to see the
        // wireframe for each widget.
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Test with Headline style
          const Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            //apply padding to all four sides
            child: Text(
              'Typy zajęć',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            height: 100,
            child: ListView(
                scrollDirection: Axis.horizontal,
                children: categories.map((e) {
                  return Container(
                    width: 90,
                    // color: Colors.red,
                    child: Column(
                      children: [
                        Icon(e.$1, size: 72),
                        Text(e.$2),
                      ],
                    ),
                  );
                }).toList()),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            //apply padding to all four sides
            child: Text(
              'Mapa',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SizedBox(
              height: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FlutterMap(
                  options: const MapOptions(
                    initialCenter: LatLng(52.2117577, 20.9823755),
                    initialZoom: 16,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                    ),
                    MarkerLayer(markers: [
                      Marker(
                        width: 80.0,
                        height: 80.0,
                        point: LatLng(52.2117577, 20.9823755),
                        child: Container(
                          child: Icon(Icons.circle, color: Theme.of(context).colorScheme.tertiary),
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
