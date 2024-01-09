import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:warszta_wawa/data/Workshops.dart';
import 'package:warszta_wawa/data/WorkshopsData.dart';

import '../data/CommonData.dart';
import '../main.dart';

Widget makeSingleWorkshop(
    BuildContext context, CommonData? commonData, MyHomePageState state) {
  Workshops? workshops = state.selectedWorkshop;
  if (workshops == null) {
    return Text('Something went wrong!');
  }
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          makeTile(
            context,
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    workshops.title,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: makeRichText(
                    'Miejsce: ',
                    'Dzielnica ' + workshops.district + ", Warszawa",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: makeRichText(
                    'Adres: ',
                    makeAddress(workshops.place),
                  ),
                ),
              ],
            ),
            Colors.white,
          ),
          loadImage(workshops, state),
          SizedBox(height: 100),
        ],
      ),
    ),
  );
}

Widget loadImage(Workshops workshops, MyHomePageState state) {
  AssetImage? image = state.imageAssets[workshops.type];
  if (image == null) {
    return Text('Something went wrong!');
  }
  return Padding(
    padding: const EdgeInsets.only(top: 16.0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: ClipRect(
        child: Container(
          child: Align(
            alignment: Alignment.center,
            widthFactor: 1,
            heightFactor: 0.7,
            child: Image(
              image: image,
            ),
          ),
        ),
      ),
    ),
  );
}

String makeAddress(String address) {
  var expectedEnd = ', 00-001 Warszawa, Poland';
  return address.substring(0, address.length - expectedEnd.length);
}

Widget makeTile(BuildContext context, Widget inside, Color color) {
  return Padding(
    padding: const EdgeInsets.only(top: 16.0),
    child: Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 0.1,
            offset: Offset(0, 1), // Shadow position
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: inside,
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
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ],
    ),
  );
}
