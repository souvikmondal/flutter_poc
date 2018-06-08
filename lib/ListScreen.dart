import 'dart:async';

import 'package:flutter/material.dart';
import 'package:poc/data/databasehelper.dart';
import 'package:poc/model/formdata.dart';

List<FormData> fetchData() {
  List<FormData> listData = new List<FormData>();
  var db = DatabaseHelper.instance;
  final response = db.getAllData();
  Future<List<FormData>> data = response;
  data.then((onValue) => listData.addAll(onValue));
  var size = listData.length;
  print("db length  $size");
  return listData;
}

_getItemView(BuildContext context) async {
  List<FormData> datas = await fetchData();
  final List<Widget> tiles = <Widget>[];
  for (int index = 0; index < datas.length; index++) {
    tiles.add(new Row(
      children: <Widget>[
        new Text(datas.elementAt(index).name),
        new Text(datas.elementAt(index).email),
        new Text(datas.elementAt(index).mobile),
        new Text(datas.elementAt(index).age),
        new Text(datas.elementAt(index).imagepath),
        new Text(datas.elementAt(index).location),
      ],
    ));
  }

  return tiles;
}

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    fetchData();
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("List Screen"),
        ),
        body: new ListView(
          children: <Widget>[
            new Text("DATA 1"),
            new Text("DATA 2"),
            new Text("DATA 3"),
            new Text("DATA 4"),
            new Text("DATA 5"),
          ],
        ));
  }
}

