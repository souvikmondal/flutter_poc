import 'dart:async';

import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';
import 'package:map_view/location.dart' as LL;
import 'package:geolocation/geolocation.dart';
import 'package:poc/com/tarento/views/colors.dart';
import 'package:poc/com/tarento/views/template_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double lat, lon, latitude, longitude;

  initState() {
    super.initState();
    _currentLocation();
  }

  Future _currentLocation() async {
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
            lat = result.location.latitude;
            lon = result.location.longitude;
          }
        });
      } else {
        print("location permission is not granted");

        // location permission is not granted
        // user might have denied, but it's also possible that location service is not enabled, restricted, and user never saw the permission request dialog
      }
    } else {
      print(
          "location service is not enabled, restricted, or location permission is denied");
      // location service is not enabled, restricted, or location permission is denied
    }
  }

  void showMap() {
    var _mapView = new MapView();
    _mapView.show(
        new MapOptions(
            title: "Events",
            mapViewType: MapViewType.normal,
            showUserLocation: true,
            initialCameraPosition:
                new CameraPosition(new LL.Location(lat, lon), 14.0)),
        toolbarActions: [new ToolbarAction("Close", 1)]);

    _mapView.onMapReady.listen((location) {
      LL.Location currentLocation = new LL.Location(lat, lon);
      _mapView.addMarker(new Marker(
          "", "", currentLocation.latitude, currentLocation.longitude,
          color: Colors.redAccent));
    });

    _mapView.onMapTapped.listen((location) {
      var markers = _mapView.markers;
      markers.forEach((marker) {
        _mapView.removeMarker(marker);
      });

      _mapView.addMarker(new Marker(
          "", "", location.latitude, location.longitude,
          color: Colors.blueAccent));
    });

    _mapView.onTouchAnnotation.listen((marker) {
      latitude = marker.latitude;
      longitude = marker.longitude;
      print("latitude --->>>$latitude");
      print("latitude --->>>$longitude");
      _mapView.dismiss();

      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => new TemplateListPage()));
    });

    _mapView.onToolbarAction.listen((id) {
      if (id == 1) {
        _mapView.dismiss();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: showMap,
        backgroundColor: Colors.indigo,
        child: Icon(
          Icons.add,
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
            onPressed: showMap,
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
                        new InkWell(
                          child: new Container(
                            padding: const EdgeInsets.all(20.0),
                            decoration: new BoxDecoration(
                              color: AppColors.darkGreen,
                              shape: BoxShape.circle,
                            ),
                            child: new Column(
                              children: <Widget>[
                                new Text(
                                  "10",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                        new Padding(
                          padding: new EdgeInsets.only(top: 10.0),
                          child: new Text(
                            "Post",
                            style: TextStyle(color: AppColors.darkGreen),
                          ),
                        )
//                        new Text("Post"),
                      ],
                    ),
                    new Column(
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
                                new Text(
                                  "15",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
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
                        new InkWell(
                          child: new Container(
                            padding: const EdgeInsets.all(20.0),
                            decoration: new BoxDecoration(
                              color: AppColors.darkGreen,
                              shape: BoxShape.circle,
                            ),
                            child: new Column(
                              children: <Widget>[
                                new Text("06",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
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
                        new InkWell(
                          child: new Container(
                            padding: const EdgeInsets.all(20.0),
                            decoration: new BoxDecoration(
                              color: AppColors.darkGreen,
                              shape: BoxShape.circle,
                            ),
                            child: new Column(
                              children: <Widget>[
                                new Text("32",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
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
