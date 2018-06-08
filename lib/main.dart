import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';
import 'package:poc/Formscreen.dart';
import 'package:poc/com/tarento/map/colors.dart';

void main() {
  MapView.setApiKey("AIzaSyANMfbEoDVoLYnLxs12IpREyFHG62-HWEE");
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter POC',
      theme: new ThemeData(
        primarySwatch: AppColors.green,
      ),
      home: new ItemListScreen(),
    );
  }
}

class ItemListScreen extends StatelessWidget {
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

  List<Widget> _getGridItems(List<String> imageList, BuildContext context) {
    final List<Widget> tiles = <Widget>[];
    for (int i = 0; i < imageList.length; i++) {
      tiles.add(new GridTile(
          child: new InkResponse(
        enableFeedback: true,
        child: new Image.asset(
          imageList[i],
          height: 100.0,
          width: 100.0,
        ),
        onTap: () => _onItemClicked(i, context),
      )));
    }
    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    List<String> imageList = new List<String>();
    imageList.add('images/alien.png');
    imageList.add('images/audio.png');
    imageList.add('images/ball_basketball.png');
    imageList.add('images/blu_ray.png');
    imageList.add('images/cd_disk.png');
    imageList.add('images/chroma_key.png');
    imageList.add('images/dial.png');
    imageList.add('images/eject.png');
    imageList.add('images/first.png');
    imageList.add('images/ipod.png');
    imageList.add('images/last.png');
    imageList.add('images/lcd.png');

    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Second Screen"),
        ),
        body: new GridView.count(
          crossAxisCount: 3,
          childAspectRatio: 3.0,
          padding: const EdgeInsets.all(5.0),
          mainAxisSpacing: 5.0,
          crossAxisSpacing: 5.0,
          children: _getGridItems(imageList, context),
        ));
  }
}
