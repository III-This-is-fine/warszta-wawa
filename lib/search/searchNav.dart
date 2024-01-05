import 'package:flutter/material.dart';
import '../data/CommonData.dart';
import '../main.dart';

Widget makeSearch(MyHomePageState homePageState, BuildContext context,
    CommonData? _commonData) {
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
                      leading: Icon(Icons.search,
                          color: Theme.of(context).colorScheme.tertiary,
                          size: 35),
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
              Text(''),
              subtitle('Typ'),
              SizedBox(
                height: 200,
                child: Text('aaa'),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
