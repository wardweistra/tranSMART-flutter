import 'package:flutter/material.dart';
import 'package:glowing_bear_mobile/screens/show_graphs.dart';
import 'package:glowing_bear_mobile/screens/server_list.dart';

final routes = {
  '/serverlist':         (BuildContext context) => new ServerList(),
  '/showgraphs':         (BuildContext context) => new ShowGraphs(),
};