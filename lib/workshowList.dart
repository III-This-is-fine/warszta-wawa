import 'package:flutter/material.dart';
import 'package:warszta_wawa/data/CommonData.dart';

import 'data/Workshops.dart';

Widget makeWorkshopList(
    BuildContext context, List<Workshops> workshops, CommonData commonData) {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Wrap(
                children: workshops
                    .map((e) => makeWorkshopTile(e, commonData))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget makeRichText(String text, String boldText) {
  return RichText(
    text: TextSpan(
      children: <TextSpan>[
        TextSpan(
          text: text,
          style: const TextStyle(color: Colors.black54),
        ),
        TextSpan(
          text: boldText,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}

Widget makeWorkshopTile(Workshops workshops, CommonData commonData) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Icon(
            commonData.getIcon(workshops.type),
            size: 60,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  workshops.title,
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                makeRichText('Typ: ', workshops.type),
              ],
            ),
          ),
        ],
      ),
      SizedBox(height: 10),
      makeRichText('Miejsce: ', workshops.place),
      SizedBox(height: 10),
      makeRichText('Termin: ', workshops.day),
      SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          makeRichText('Godzina: ', makeAgeRange(workshops.age)),
          makeRichText('Cena: ', workshops.price),
        ],
      ),
    ],
  );
}

String makeAgeRange((int, int) age) {
  return age.$1.toString() + '-' + age.$2.toString() + ' lat';
}
