
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
