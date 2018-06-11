import 'dart:async';

import 'package:flutter/material.dart';
import 'package:poc/data/databasehelper.dart';
import 'package:poc/model/formdata.dart';


class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<FormData> listData;

  Future<List<FormData>> getListViewData() async {
    var db = DatabaseHelper.instance;
    List<FormData> response = await db.getAllData();
    this.setState(() {
      this.listData = response;
    });
    return response;
  }

  @override
  void initState() {
    // TODO: implement initState
    this.getListViewData();
  }

  @override
  Widget build(BuildContext context) {
    // fetchData();
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("List Screen"),
        ),
        body: new ListView.builder(
          itemCount: listData == null ? 0 : listData.length,
          itemBuilder: (BuildContext context, int index) {
            return new Card(
              child: new Row(
                children: <Widget>[
                  new Text(listData[index].name),
                  new Padding(padding: const EdgeInsets.all(5.0)),
                  new Text(listData[index].email),
                  new Padding(padding: const EdgeInsets.all(5.0)),
                  new Text(listData[index].mobile),
                  new Padding(padding: const EdgeInsets.all(5.0)),
                  new Text(listData[index].age),
                  new Padding(padding: const EdgeInsets.all(5.0)),
                  new Text(listData[index].imagepath),
                  new Padding(padding: const EdgeInsets.all(5.0)),
                  new Text(listData[index].location),
                  new Padding(padding: const EdgeInsets.all(5.0)),
                ],
              ),
            );
          },
        ));
  }
}
