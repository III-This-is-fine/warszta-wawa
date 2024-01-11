import 'package:flutter/material.dart';
import 'package:text_scroll/text_scroll.dart';
import 'package:warszta_wawa/data/CommonData.dart';
import 'package:warszta_wawa/main.dart';

import 'data/Workshops.dart';

Widget makeWorkshopList(
  BuildContext context,
  List<Workshops> workshops,
  CommonData commonData,
  MyHomePageState state,
  bool offset,
  double sizedBoxHeight,
) {
  return Padding(
    padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Wrap(
          children: workshops
                  .map(
                    (e) => GestureDetector(
                      onTap: () {
                        state.setState(() {
                          state.setSelectedWorkshop(e);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Container(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: makeWorkshopTile(e, commonData, state),
                            ),
                          ),
                        ),
                      ),
                    ) as Widget,
                  )
                  .toList() +
              [
                SizedBox(
                  height: sizedBoxHeight,
                )
              ],
        ),
      ],
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
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ],
    ),
  );
}

Widget makeWorkshopTile(
    Workshops workshops, CommonData commonData, MyHomePageState state) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Icon(
            commonData.getIcon(workshops.type),
            size: 60,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextScroll(
                    workshops.title,
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    mode: TextScrollMode.bouncing,
                    delayBefore: Duration(seconds: 2),
                    pauseBetween: Duration(seconds: 2),
                    textAlign: TextAlign.right,
                  ),
                  makeRichText('Typ: ', workshops.type),
                ],
              ),
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
          makeRichText('Wiek: ', makeAgeRange(workshops.age)),
          makeRichText('Cena: ', workshops.price),
        ],
      ),
    ],
  );
}

String makeAgeRange((int, int) age) {
  if (age.$1 == age.$2) {
    return age.$1.toString() + ' lat';
  }
  return age.$1.toString() + '-' + age.$2.toString() + ' lat';
}
