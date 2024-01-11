import 'package:flutter/material.dart';
import '../data/CommonData.dart';
import '../main.dart';

Widget makeSearch(
  MyHomePageState homePageState,
  BuildContext context,
  CommonData? _commonData,
) {
  var size = MediaQuery.of(context).size;
  var ratio = (size.width - 64) / 100;

  return SingleChildScrollView(
    child: Padding(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  children: [
                    SearchAnchor(builder: (
                      BuildContext context,
                      SearchController controller,
                    ) {
                      return SearchBar(
                        controller: controller,
                        padding: const MaterialStatePropertyAll<EdgeInsets>(
                            EdgeInsets.symmetric(horizontal: 16.0)),
                        onTap: () {
                          controller.openView();
                        },
                        onChanged: (_) {
                          controller.openView();
                        },
                        leading: Icon(
                          Icons.search,
                          color: Theme.of(context).colorScheme.tertiary,
                          size: 35,
                        ),
                        hintText: 'Wpisz co lub gdzie Cię interesuje',
                        hintStyle: MaterialStateProperty.resolveWith(
                            (states) => TextStyle(color: Colors.grey)),
                        shape: MaterialStateProperty.resolveWith(
                          (states) => RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.0),
                            side: BorderSide(
                                color: Theme.of(context).colorScheme.tertiary,
                                width: 2.0),
                          ),
                        ),
                      );
                    }, suggestionsBuilder: (
                      BuildContext context,
                      SearchController controller,
                    ) {
                      return List<ListTile>.generate(5, (int index) {
                        final String item = 'item $index';
                        return ListTile(
                          title: Text(item),
                          onTap: () {
                            homePageState.setState(() {
                              controller.closeView(item);
                            });
                          },
                        );
                      });
                    }),
                  ],
                ),
                Text('\n'),
                subtitle('Typ'),
                SizedBox(
                  height: 200,
                  child: GridView.count(
                    crossAxisCount: 2,
                    physics: new NeverScrollableScrollPhysics(),
                    childAspectRatio: ratio,
                    controller: new ScrollController(keepScrollOffset: false),
                    shrinkWrap: true,
                    children: _commonData!.categories.map((e) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            homePageState.setState(() {
                              homePageState.setCategory(
                                  e.$2, !homePageState.getCategory(e.$2));
                            });
                          },
                          child: Center(
                            child: Row(
                              children: [
                                Checkbox(
                                  value: homePageState.getCategory(e.$2),
                                  activeColor:
                                      Theme.of(context).colorScheme.tertiary,
                                  onChanged: (bool? value) {
                                    if (value != null) {
                                      homePageState.setState(() {
                                        homePageState.setCategory(e.$2, value);
                                      });
                                    }
                                  },
                                ),
                                Text(
                                  e.$2,
                                  textAlign: TextAlign.left,
                                  textScaler: TextScaler.linear(1.2),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Text(''),
                subtitle('Miejsce'),
                Wrap(
                  children: [
                    SearchAnchor(builder: (
                      BuildContext context,
                      SearchController controller,
                    ) {
                      controller.value = TextEditingValue(text: homePageState.district);
                      return SearchBar(
                        controller: controller,
                        padding: const MaterialStatePropertyAll<EdgeInsets>(
                            EdgeInsets.symmetric(horizontal: 16.0)),
                        onTap: () {
                          controller.openView();
                        },
                        onSubmitted: (_) {
                          print('submitted');
                          homePageState.setState(() {
                            homePageState.district = controller.text;
                          });
                          controller.openView();
                        },
                        onChanged: (_) {
                          print('changed');
                          homePageState.setState(() {
                            homePageState.district = controller.text;
                          });
                          controller.openView();
                        },
                        trailing: [
                          Icon(
                            Icons.arrow_drop_down_sharp,
                            color: Theme.of(context).colorScheme.tertiary,
                            size: 35,
                          )
                        ],
                        hintText: 'Wpisz lub wyszukaj',
                        hintStyle: MaterialStateProperty.resolveWith(
                          (states) => TextStyle(color: Colors.grey),
                        ),
                        shape: MaterialStateProperty.resolveWith(
                          (states) => RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.0),
                            side: BorderSide(
                                color: Theme.of(context).colorScheme.tertiary,
                                width: 2.0),
                          ),
                        ),
                      );
                    }, suggestionsBuilder: (
                      BuildContext context,
                      SearchController controller,
                    ) {
                      return _commonData.districts.map((dis) {
                        final String item = dis.$1;
                        return ListTile(
                          title: Text(item),
                          onTap: () {
                            homePageState.setState(() {
                              homePageState.district = item;
                            });
                            controller.closeView(item);
                          },
                        );
                      }).toList();
                    }),
                  ],
                ),
                Text('\n'),
                subtitle('Wiek'),
                RangeSlider(
                  values: homePageState.currentAgeRange,
                  activeColor: Theme.of(context).colorScheme.tertiary,
                  inactiveColor: Colors.grey,
                  max: 15,
                  min: 3,
                  divisions: 15 - 3,
                  labels: RangeLabels(
                    homePageState.currentAgeRange.start.round().toString(),
                    homePageState.currentAgeRange.end.round().toString(),
                  ),
                  onChanged: (RangeValues values) {
                    homePageState.setState(() {
                      homePageState.currentAgeRange = values;
                    });
                  },
                ),
                Text(''),
                subtitle('Cena'),
                SizedBox(
                  height: 50,
                  child: GridView.count(
                    crossAxisCount: 2,
                    physics: new NeverScrollableScrollPhysics(),
                    childAspectRatio: ratio,
                    controller: new ScrollController(keepScrollOffset: false),
                    shrinkWrap: true,
                    children: homePageState.priceSelected.entries.map((e) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            homePageState.setState(() {
                              homePageState.flipPrice(e.key);
                            });
                          },
                          child: Center(
                            child: Row(
                              children: [
                                Checkbox(
                                  value: homePageState.getPrice(e.key),
                                  activeColor:
                                      Theme.of(context).colorScheme.tertiary,
                                  onChanged: (bool? value) {
                                    if (value != null) {
                                      homePageState.setState(() {
                                        homePageState.flipPrice(e.key);
                                      });
                                    }
                                  },
                                ),
                                Text(
                                  e.key,
                                  textAlign: TextAlign.left,
                                  textScaler: TextScaler.linear(1.2),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Text('\n'),
                subtitle('Charakter'),
                SizedBox(
                  height: 50,
                  child: GridView.count(
                    crossAxisCount: 2,
                    physics: new NeverScrollableScrollPhysics(),
                    childAspectRatio: ratio,
                    controller: new ScrollController(keepScrollOffset: false),
                    shrinkWrap: true,
                    children: homePageState.periodSelected.entries.map((e) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            homePageState.setState(() {
                              homePageState.flipPeriod(e.key);
                            });
                          },
                          child: Center(
                            child: Row(
                              children: [
                                Checkbox(
                                  value: homePageState.getPeriod(e.key),
                                  activeColor:
                                      Theme.of(context).colorScheme.tertiary,
                                  onChanged: (bool? value) {
                                    if (value != null) {
                                      homePageState.setState(() {
                                        homePageState.flipPeriod(e.key);
                                      });
                                    }
                                  },
                                ),
                                Text(
                                  e.key,
                                  textAlign: TextAlign.left,
                                  textScaler: TextScaler.linear(1.2),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Text('\n'),
                subtitle('Dzień'),
                SizedBox(
                  height: 200,
                  child: GridView.count(
                    crossAxisCount: 2,
                    physics: new NeverScrollableScrollPhysics(),
                    childAspectRatio: ratio,
                    controller: new ScrollController(keepScrollOffset: false),
                    shrinkWrap: true,
                    children: homePageState.daySelected.entries.map((e) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            homePageState.setState(() {
                              homePageState.flipDay(e.key);
                            });
                          },
                          child: Center(
                            child: Row(
                              children: [
                                Checkbox(
                                  value: homePageState.getDay(e.key),
                                  activeColor:
                                      Theme.of(context).colorScheme.tertiary,
                                  onChanged: (bool? value) {
                                    if (value != null) {
                                      homePageState.setState(() {
                                        homePageState.flipDay(e.key);
                                      });
                                    }
                                  },
                                ),
                                Text(
                                  e.key,
                                  textAlign: TextAlign.left,
                                  textScaler: TextScaler.linear(1.2),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 150),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
