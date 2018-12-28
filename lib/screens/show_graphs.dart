import 'package:flutter/material.dart';

class ShowGraphs extends StatefulWidget {
  @override
  createState() => new ShowGraphsState();
}

class ShowGraphsState extends State<ShowGraphs> {
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Glowing Bear Mobile'),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.vpn_key),
              onPressed: () {
                Navigator.pushNamed(context, '/serverlist');
              }),
        ],
      ),
      body: _variableGraphs(),
    );
  }

  Widget _variableGraphs() {
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          // Add a one-pixel-high divider widget before each row in theListView.
          if (i.isOdd) return new Divider();
          final index = i ~/ 2;
          return new Text('Graph $index');
        });
  }

  Widget _buildRow(String graph) {
    return new ListTile(
      title: new Text(
        graph,
        style: _biggerFont,
      ),
    );
  }
}
