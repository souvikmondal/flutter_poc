import 'dart:async';

import 'package:flutter/material.dart';
import 'package:poc/com/tarento/views/Formscreen.dart';
import 'package:poc/com/tarento/views/colors.dart';
import 'package:poc/model/locationdata.dart';

class TemplateListPage extends StatelessWidget {
  final LocationData locationData;

  TemplateListPage(this.locationData);

  void _onItemClicked(int index, BuildContext context, String title) {
    print("Item clicked     $index");
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new Formscreen(locationData, title)));
  }

  List<Widget> _getGridItems(
      List<IconData> imageList, List<String> titles, BuildContext context) {
    final List<Widget> tiles = <Widget>[];
    for (int i = 0; i < imageList.length; i++) {
      tiles.add(new GridTile(
          child: new Padding(
        padding: const EdgeInsets.all(15.0),
        child: new InkResponse(
          enableFeedback: true,
          child: new Column(
            children: <Widget>[
              new InkWell(
                child: new Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: new BoxDecoration(
                    color: AppColors.darkGreen,
                    shape: BoxShape.circle,
                  ),
                  child: new Column(
                    children: <Widget>[
                      new Icon(imageList[i],
                          size: 25.0, color: Colors.lightGreenAccent)
                    ],
                  ),
                ),
                onTap: () {
                  _onItemClicked(i, context, titles[i]);
                },
              ),
              new Padding(
                padding: new EdgeInsets.only(top: 10.0),
                child: new Text(
                  titles[i],
                  style: new TextStyle(color: AppColors.darkGreen),
                ),
              )
            ],
          ),
        ),
      )));
    }
    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    List<IconData> imageList = new List<IconData>();
    imageList.add(Icons.healing);
    imageList.add(Icons.airplanemode_active);
    imageList.add(Icons.book);
    imageList.add(Icons.account_balance_wallet);
    imageList.add(Icons.home);
    imageList.add(Icons.accessibility);
    imageList.add(Icons.event_seat);

    List<String> titles = new List<String>();
    titles.add("Health");
    titles.add("Travel");
    titles.add("Education");
    titles.add("Finance");
    titles.add("Real Estate");
    titles.add("Sports");
    titles.add("Technology");

    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Select Template", style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.lightGreen,
        ),
        body: new GridView.count(
          crossAxisCount: 3,
          padding: const EdgeInsets.all(5.0),
          children: _getGridItems(imageList, titles, context),
        ));
  }
}
