import 'package:flutter/material.dart';
import 'package:sistema_contato/helpers/help_contacts.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {

  ContactHelper helper = ContactHelper();


  @override
  void initState() {
    super.initState();

    Contact c = Contact();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

s