import 'package:flutter/material.dart';
import 'package:flutter_application_3/aboutTheDev.dart';
import 'package:flutter_application_3/databaseHelper.dart';

class CompletedItems extends StatefulWidget {
  const CompletedItems({Key? key}) : super(key: key);

  @override
  _CompletedItemsState createState() => _CompletedItemsState();
}

class _CompletedItemsState extends State<CompletedItems> {
  List<Map<String, dynamic>>? _queryRows;
  List? data;

  @override
  void initState() {
    init();

    super.initState();
  }

  void init() async {
    _queryRows = await DatabaseHelper.instance.queryAll("completedItems");
    setState(() {
      _queryRows;
      print(_queryRows);
    });
  }

  // Open the page respective to the choice from top 3 dots
  void handleClick(String value) {
    switch (value) {
      // Opens the About the Developer page
      case 'About The Developer':
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => AboutTheDev()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Completed Tasks'),
        actions: [
          ElevatedButton(
            onPressed: () {
              print("pressing");
            },
            child: PopupMenuButton<String>(
              onSelected: handleClick,
              itemBuilder: (BuildContext context) {
                return {
                  'About The Developer',
                }.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _queryRows == null ? 0 : _queryRows!.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _queryRows![index]["name"],
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 24,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 4, bottom: 4),
                  child: Container(
                      child: Text(displayDateTime(index),
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.2))),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 4, bottom: 4),
                  child: Container(
                      child: Text(completedOn(index),
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              letterSpacing: 1.05))),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String displayDateTime(index) {
    String dateToBeReturned;
    DateTime date = DateTime.parse(
        _queryRows![index]["dateTime"].substring(0, 1) == "U"
            ? _queryRows![index]["dateTime"].substring(8)
            : _queryRows![index]["dateTime"].substring(6));
    return dateToBeReturned =
        "${_queryRows![index]["dateTime"].substring(0, 1) == "U" ? _queryRows![index]["dateTime"].substring(0, 8) : _queryRows![index]["dateTime"].substring(0, 6)}on ${date.day}-${date.month}-${date.year} at ${date.hour}:${date.minute}:${date.second}";
  }

  String completedOn(index) {
    String dateToBeReturned;
    DateTime date = DateTime.parse(_queryRows![index]["completedOn"]);
    return dateToBeReturned =
        "Completed on ${date.day}-${date.month}-${date.year} at ${date.hour}:${date.minute}:${date.second}";
  }
}
