import 'package:flutter/material.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';
import 'package:warszta_wawa/data/Workshops.dart';

import '../data/CommonData.dart';
import '../main.dart';

Widget makeSingleWorkshop(
    BuildContext context, CommonData? commonData, MyHomePageState state) {
  Workshops? workshops = state.selectedWorkshop;
  if (workshops == null) {
    return Text('Something went wrong!');
  }
  return Padding(
    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
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
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    workshops.title,
                    style: TextStyle(
                      fontSize: 30,
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
            10.0,
          ),
          loadImage(workshops, state),
          makeInformation(context, workshops, state),
          makeTile(
            context,
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Opis zajęć',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    workshops.description + ' ' + loremIpsum(paragraphs: 3),
                  ),
                ],
              ),
            ),
            Colors.white,
            10.0,
          ),
          makeSignInInfo(context, workshops, state),
          SizedBox(height: 160),
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

Widget makeTile(BuildContext context, Widget inside, Color color, double bottomPad) {
  return Padding(
    padding: const EdgeInsets.only(top: 16.0),
    child: Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 0.01,
            offset: Offset(0, 1), // Shadow position
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 10.0, bottom: bottomPad),
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
          style: const TextStyle(color: Colors.black87),
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

Widget makeRichTextLinks(String text, String boldText) {
  return RichText(
    text: TextSpan(
      children: <TextSpan>[
        TextSpan(
          text: text,
          style: const TextStyle(color: Colors.black87),
        ),
        TextSpan(
          text: boldText,
          style: TextStyle(
              decoration: TextDecoration.underline, color: Colors.blue),
        ),
      ],
    ),
  );
}

Widget makeInformation(
  BuildContext context,
  Workshops workshops,
  MyHomePageState state,
) {
  return makeTile(
    context,
    Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: makeStripedList(
        context,
        workshops,
        state,
        [
          Text(
            'Informacje',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          makeRichText(
            'Typ: ',
            workshops.type,
          ),
          makeRichText(
            'Grupa wiekowa: ',
            makeAge(workshops.age),
          ),
          makeRichText(
            'Cena: ',
            workshops.price,
          ),
          makeRichText(
            'Charakter: ',
            workshops.period,
          ),
          makeRichText(
            'Termin: ',
            workshops.day,
          ),
          makeRichText(
            'Strona zajęć: ',
            'www.wck.art.waw.pl',
          ),
        ],
        false,
      ),
    ),
    Theme.of(context).colorScheme.primaryContainer,
    10.0,
  );
}

String makeAge((int, int) age) {
  if (age.$1 == age.$2) {
    return age.$1.toString() + ' lat';
  }
  return age.$1.toString() + '-' + age.$2.toString() + ' lat';
}

Widget makeSignInInfo(
  BuildContext context,
  Workshops workshops,
  MyHomePageState state,
) {
  return makeTile(
    context,
    Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: makeStripedList(
        context,
        workshops,
        state,
        [
          Text(
            'Jak zapisać?',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          makeRichTextLinks(
            'Telefon: ',
            '+48 123 456 789',
          ),
          makeRichTextLinks(
            'Email: ',
            'wck.art@kultura.waw.pl',
          ),
          makeRichTextLinks(
            'Link do zajęć: ',
            'www.wck.art.waw.pl',
          ),
        ],
        true,
      ),
    ),
    Color.fromARGB(255, 223, 197, 255),
    16.0,
  );
}

List<Widget> makeStripedList(
  BuildContext context,
  Workshops workshops,
  MyHomePageState state,
  List<Widget> children,
  bool allFromSecond,
) {
  List<Widget> result = [];
  for (var i = 0; i < children.length; i++) {
    result.add(Container(
      color: ((allFromSecond && i == 0) || (!allFromSecond && i % 2 == 0)) ? null : Colors.grey[300],
      child: Container(
        margin: const EdgeInsets.all(12.0),
        child: children[i],
      ),
    ));
  }
  return result;
}
