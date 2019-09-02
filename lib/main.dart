import 'package:flutter/material.dart';
import 'interfaces/list_screen.dart';

void main() {
  runApp(MaterialApp(
      home: ListScreen(),
      debugShowCheckedModeBanner: false,
      theme:
          ThemeData(primaryColor: Colors.orange, primarySwatch: Colors.amber)));
}
