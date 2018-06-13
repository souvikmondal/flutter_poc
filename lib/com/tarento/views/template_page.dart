import 'package:flutter/material.dart';
import 'package:poc/com/tarento/views/Formscreen.dart';
import 'package:poc/com/tarento/views/colors.dart';

class TemplateListPage extends StatelessWidget {
  void _onItemClicked(int index, BuildContext context) {
    print("Item clicked     $index");
    if (index % 2 == 0) {
      openFormScreen(context);
    }
  }

  void openFormScreen(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => new Formscreen()));
  }

  List<Widget> _getGridItems(List<IconData> imageList, List<String> titles, BuildContext context) {
    final List<Widget> tiles = <Widget>[];
    for (int i = 0; i < imageList.length; i++) {
      tiles.add(new GridTile(
          child: new Column(
            children: <Widget>[
              new FloatingActionButton(
                onPressed: () {
                  _onItemClicked(i, context);
                },
                backgroundColor: AppColors.darkGreen,
                child: Icon(
                  imageList[i],
                  color: Colors.white,
                ),
              ),
              new Padding(
                padding: new EdgeInsets.only(top: 10.0),
                child: new Text(
                  titles[i],
                  style: TextStyle(color: AppColors.darkGreen),
                ),
              )
            ],
          ),));
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
          title: new Text("Select Template"),
        ),
        body: new GridView.count(
          crossAxisCount: 3,
          childAspectRatio: 3.0,
          padding: const EdgeInsets.all(5.0),
          mainAxisSpacing: 5.0,
          crossAxisSpacing: 5.0,
          children: _getGridItems(imageList, titles, context),
        ));
  }
}