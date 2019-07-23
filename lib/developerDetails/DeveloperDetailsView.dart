import 'package:hello_flutter/models/Developer.dart';
import 'package:flutter/material.dart';

class DeveloperDetails extends StatelessWidget {
  DeveloperDetails(
    this.developer, {
    @required this.keyTag,
  });

  final Developer developer;
  final Object keyTag;

  /*alertdialog for the hire button*/
  Future<void> _showAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hire Me'),
          content: const Text('Oops this function is not available'),
          actions: <Widget>[
            FlatButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    /*widget to display developer image with back arrow imageview*/
    final topContent = Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 10.0),
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new NetworkImage(developer.getAvatar_url),
                fit: BoxFit.cover,
              ),
            )),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.blueGrey),
          ),
        )
      ],
    );

    /*widget to display username of the developer*/
    final usernameContentText = Text(
      developer.getLogin,
      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
    );

    /*widget to display url of the developer account*/
    final urlContentText = Text(
      developer.getHtml_url,
      style: TextStyle(fontSize: 16.0),
    );

    /*widget to display the type of user*/
    final userTypeContentText = Text(
      developer.getType,
      style: TextStyle(fontSize: 14.0),
    );

    /*widget showing hire button*/
    final hireButton = Container(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          onPressed: () => _showAlert(context),
          color: Colors.blue,
          child: Text("HIRE ME", style: TextStyle(color: Colors.white)),
        ));

    /*container widget holding all widgets below the image widget*/
    final bottomContent = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          children: <Widget>[
            usernameContentText,
            urlContentText,
            userTypeContentText,
            hireButton
          ],
        ),
      ),
    );

    return Scaffold(
      body: Column(
        children: <Widget>[topContent, bottomContent],
      ),
    );
  }
}
