import 'dart:async';

import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';
import 'package:map_view/location.dart' as LL;
import 'package:geolocation/geolocation.dart';
import 'package:poc/com/tarento/map/colors.dart';

class MapPage extends StatefulWidget {
  MapPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MapPageState createState() => new _MapPageState();
}

class _MapPageState extends State<MapPage> {
  var _loadingMap = false;
  var _fetchLocation = false;
  GlobalKey _scaffoldKey = null;

  Future _currentLocation() async {
    _fetchLocation = true;

    final GeolocationResult result = await Geolocation.isLocationOperational();
    if (result.isSuccessful) {
      final GeolocationResult result =
          await Geolocation.requestLocationPermission(const LocationPermission(
        android: LocationPermissionAndroid.fine,
        ios: LocationPermissionIOS.always,
      ));

      if (result.isSuccessful) {
        Geolocation
            .currentLocation(accuracy: LocationAccuracy.best)
            .listen((result) {
          if (result.isSuccessful) {
            double lat = result.location.latitude;
            double lon = result.location.longitude;
            setState(() {
              _fetchLocation = true;
              showMap(lat, lon);
            });
          } else {
            setState(() {
              _fetchLocation = false;
            });
          }
        });
      } else {
        setState(() {
          _fetchLocation = false;
        });
        print("location permission is not granted");

        // location permission is not granted
        // user might have denied, but it's also possible that location service is not enabled, restricted, and user never saw the permission request dialog
      }
    } else {
      setState(() {
        _fetchLocation = false;
      });
      print(
          "location service is not enabled, restricted, or location permission is denied");
      // location service is not enabled, restricted, or location permission is denied
    }
  }

  void showMap(lat, lon) {
    var _mapView = new MapView();
    _mapView.show(
        new MapOptions(
            title: "Events",
            mapViewType: MapViewType.normal,
            showUserLocation: true,
            initialCameraPosition:
                new CameraPosition(new LL.Location(lat, lon), 14.0)),
        toolbarActions: [new ToolbarAction("Close", 1)]);

    _mapView.onMapTapped.listen((location) {
      var markers = _mapView.markers;
      markers.forEach((marker) {
        _mapView.removeMarker(marker);
      });

      _mapView.addMarker(new Marker(
          "", "", location.latitude, location.longitude,
          color: Colors.blueAccent));
    });
  }

  @override
  Widget build(BuildContext context) {
    _scaffoldKey = new GlobalKey<ScaffoldState>();
    return new Scaffold(
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton(
        onPressed: _currentLocation,
        backgroundColor: Colors.indigo,
        child: Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
      appBar: new AppBar(
        title: new Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(
              Icons.add_location,
              color: Colors.white,
            ),
            onPressed: _currentLocation,
          )
        ],
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Card(
              child: new Column(
                children: <Widget>[
                  new Image.asset('images/swimming.png'),
                ],
              ),
            ),
            new Padding(
                padding: new EdgeInsets.all(10.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new Column(
                      children: <Widget>[
                        new FloatingActionButton(
                          onPressed: () {},
                          backgroundColor: AppColors.darkGreen,
                          child: Text(
                            "10",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        new Padding(
                          padding: new EdgeInsets.only(top: 10.0),
                          child: new Text(
                            "Post",
                            style: TextStyle(color: AppColors.darkGreen),
                          ),
                        )
                      ],
                    ),
                    new Column(
                      children: <Widget>[
                        new FloatingActionButton(
                          onPressed: () {},
                          backgroundColor: AppColors.darkGreen,
                          child: Text(
                            "15",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        new Padding(
                          padding: new EdgeInsets.only(top: 10.0),
                          child: new Text(
                            "Members",
                            style: TextStyle(color: AppColors.darkGreen),
                          ),
                        )
                      ],
                    ),
                    new Column(
                      children: <Widget>[
                        new FloatingActionButton(
                          onPressed: () {},
                          backgroundColor: AppColors.darkGreen,
                          child: Text(
                            "06",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        new Padding(
                          padding: new EdgeInsets.only(top: 10.0),
                          child: new Text(
                            "Templates",
                            style: TextStyle(color: AppColors.darkGreen),
                          ),
                        )
                      ],
                    ),
                    new Column(
                      children: <Widget>[
                        new FloatingActionButton(
                          onPressed: () {},
                          backgroundColor: AppColors.darkGreen,
                          child: Image.asset('images/swimming.png'),
                        ),
                        new Padding(
                          padding: new EdgeInsets.only(top: 10.0),
                          child: new Text(
                            "Sports",
                            style: TextStyle(color: AppColors.darkGreen),
                          ),
                        )
                      ],
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
