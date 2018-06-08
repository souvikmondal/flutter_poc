import 'package:flutter/material.dart';
import 'package:poc/com/tarento/map/colors.dart';
import 'package:poc/com/tarento/map/map_page.dart';
import 'package:map_view/map_view.dart';

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
      home: new MapPage(title: 'Sports Events'),
    );
  }
}

