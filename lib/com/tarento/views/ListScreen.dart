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
          backgroundColor: Colors.lightGreen,
        ),
        body: new ListView.builder(
          itemCount: listData == null ? 0 : listData.length,
          itemBuilder: (BuildContext context, int index) {
            return new Expanded(
              child: new ListView.builder(
                  itemCount: listData == null ? 0 : listData.length,
                  itemBuilder: (BuildContext context, int index){
                    return new Card(
                        elevation: 4.0,
                        color: Colors.white,
                        child: new Padding(padding: const EdgeInsets.all(15.0),
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              new Text(listData[index].name, style: new TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0,
                                color: Colors.black,

                              )),
                              new Text(listData[index].email, style: new TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,

                              )),
                              new Text(listData[index].age, style: new TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,

                              )),
                              new Text(listData[index].mobile, style: new TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,

                              )),
                              new Text(listData[index].latitude, style: new TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,


                              )),
                              new Text(listData[index].longitude, style: new TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,

                              )),
                            ],
                          ),)
                    );
                  }),
            );
          },
        ));
  }
}
