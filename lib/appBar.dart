import 'package:flutter/material.dart';

var appBar = (Widget logo) => AppBar(
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
      title: Align(
        alignment: Alignment.center,
        child: logo,
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {},
          iconSize: 40,
        )
      ],
      toolbarHeight: 80,
    );

var makeNavigationBar =
    (BuildContext context) => NavigationBar(destinations: <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Strona główna',
          ),
          bigSearch(context),
          NavigationDestination(
            icon: Icon(Icons.pin_drop_outlined),
            label: 'Mapa',
          ),
        ]);

var bigSearch = (BuildContext context) {
  var colors = Theme.of(context).colorScheme;
  return OverflowBox(
      maxWidth: 200,
      maxHeight: 200,
      child: ElevatedButton(
        onPressed: () {},
        child: Icon(Icons.search_outlined, color: colors.primaryContainer, size: 70),
        style: ButtonStyle(
          shape: MaterialStateProperty.all(CircleBorder()),
          padding: MaterialStateProperty.all(EdgeInsets.all(30)),
          backgroundColor: MaterialStateProperty.all(colors.tertiary),
          // <-- Button color
          overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
            if (states.contains(MaterialState.pressed))
              return colors.primary; // <-- Splash color
          }),
        ),
      ));
};
