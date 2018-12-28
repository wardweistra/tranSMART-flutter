import 'package:flutter/material.dart';
import 'routes.dart';
import 'screens/show_graphs.dart' show ShowGraphs;


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Glowing Bear Mobile',
      home: new ShowGraphs(),
      routes: routes,
    );
  }
}

