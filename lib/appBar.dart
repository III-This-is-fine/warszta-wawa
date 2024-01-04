import 'package:flutter/material.dart';

var appBar = (Widget logo) => AppBar(
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
