import 'package:flutter/material.dart';

class SerchSchoolBarApp extends StatefulWidget {
  const SerchSchoolBarApp({super.key});

  @override
  State<SerchSchoolBarApp> createState() => _SearchBarAppState();
}

class _SearchBarAppState extends State<SerchSchoolBarApp> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SearchAnchor(
        builder: (BuildContext context, SearchController controller) {
          return SearchBar(
            controller: controller,
            padding: const WidgetStatePropertyAll<EdgeInsets>(
              EdgeInsets.symmetric(horizontal: 16.0),
            ),
            onTap: () {
              controller.openView();
            },
            onChanged: (_) {
              controller.openView();
            },
            leading: const Icon(Icons.search),
            trailing: <Widget>[
              IconButton(
                onPressed: () {
                  setState(() {
                    print("Food Serch");
                  });
                },
                icon: const Icon(Icons.search),
                selectedIcon: const Icon(Icons.brightness_2_outlined),
              ),
            ],
          );
        },
        suggestionsBuilder:
            (BuildContext context, SearchController controller) {
              return List<ListTile>.generate(5, (int index) {
                final String item = 'item $index';
                return ListTile(
                  title: Text(item),
                  onTap: () {
                    setState(() {
                      controller.closeView(item);
                    });
                  },
                );
              });
            },
      ),
    );
  }
}
