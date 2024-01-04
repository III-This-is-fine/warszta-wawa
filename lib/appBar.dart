import 'package:flutter/material.dart';

PreferredSizeWidget appBar(
  Widget logo,
  bool isBackVisible,
  VoidCallback backCallback,
  VoidCallback settingsCallback,
) {
  return AppBar(
    leading: IconButton(
      color: isBackVisible ? null : Colors.transparent,
      icon: const Icon(Icons.arrow_back),
      onPressed: backCallback,
      iconSize: 40,
    ),
    title: Align(
      alignment: Alignment.center,
      child: logo,
    ),
    actions: [
      IconButton(
        icon: const Icon(Icons.settings),
        onPressed: settingsCallback,
        iconSize: 40,
      )
    ],
    toolbarHeight: 80,
  );
}
