import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hello_flutter/models/Developer.dart';
import 'package:hello_flutter/developerDetails/DeveloperDetailsView.dart';
import 'package:hello_flutter/utils/DatabaseHelper.dart';


class DevelopersView extends StatefulWidget {
  @override
  _DevelopersViewState createState() => new _DevelopersViewState();
}

class _DevelopersViewState extends State<DevelopersView> {
  DatabaseHelper db = DatabaseHelper();

  List<Developer> _developers = new List<Developer>();
  bool isLoading = true;
  String errorMsg = "";

  @override
  void initState() {
    super.initState();
    _loadDevelopersFromGithub();
  }

  /*save data retrieved from github to db*/
  _saveDataToSqflite(List<Developer> devs) async {
    for (Developer developer in devs) {
      await db.saveDeveloper(developer);
    }
  }

  /*load data from github asynchronously */
  Future<void> _loadDevelopersFromGithub() async {
    /*handle network call using try/catch in case of any unforseen exception*/
    try {
      http.Response response = await http.get("https://api.github.com/users");
      if (response.statusCode == 200) {
        var decodedJson = json.decode(response.body);
        debugPrint(response.body);
        List<Developer> devs = (decodedJson as List)
            .map<Developer>((json) => new Developer.fromJson(json))
            .toList();
        _saveDataToSqflite(devs);
      } else {
        // If that response was not OK, throw an error.
        //throw Exception('Failed to load from github');
        int status = response.statusCode;
        errorMsg = "Error: $status";
      }
    } on Exception catch (error) {
      errorMsg = error.toString();
      //debugPrint("catched exception");
      isLoading = false;
    }

    /*get all developers obj stored in database */
    List<Developer> fromDB = await db.getAllDevelopers();

    /*update ui after fetching the data from db*/
    setState(() {
      _developers.clear();
      if (fromDB != null && !fromDB.isEmpty) _developers.addAll(fromDB);
      isLoading = false;
    });
  }

  /*row widget for each rows of the listview*/
  Widget _buildDevelopersView(BuildContext context, int index) {
    var developer = _developers[index];

    return new ListTile(
      onTap: () => _navigateToDeveloperDetails(developer, index),
      leading: new Hero(
        tag: index,
        child: new CircleAvatar(
          backgroundImage: new NetworkImage(developer.getAvatar_url),
        ),
      ),
      title: new Text(developer.getLogin),
      subtitle: new Text(developer.getHtml_url),
    );
  }

  /*navigate to the detail page*/
  void _navigateToDeveloperDetails(Developer developer, Object keyTag) {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (c) {
          return new DeveloperDetails(developer, keyTag: keyTag);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    /*if developers list is empty, show circular progressbar or error message */
    if (_developers.isEmpty) {
      /*if the async call to github is still working, show circular progress, else show error message */
      if (isLoading) {
        content = new Center(child: new CircularProgressIndicator());
      } else {
        content = new Center(child: Text('No developers found.'));
        errorMsg = "";
      }
    } else {
      content = new ListView.builder(
        itemCount: _developers.length,
        itemBuilder: _buildDevelopersView,
      );
    }

    return new Scaffold(
      appBar: new AppBar(title: new Text('Developers')),
      body: content,
    );
  }
}
