import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';
import 'package:map_view/location.dart' as MapViewLocation;
import 'package:location/location.dart' as Location;
import 'package:poc/com/tarento/views/colors.dart';
import 'package:poc/com/tarento/views/template_page.dart';
import 'package:poc/data/databasehelper.dart';
import 'package:poc/model/formdata.dart';
import 'package:poc/model/locationdata.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {


  Map<String, double> _currentLocation;

  StreamSubscription<Map<String, double>> _locationSubscription;

  Location.Location _location = new Location.Location();
  String error;
  List<FormData> listData;


  Future<List<FormData>> getListViewData() async {
    var db = DatabaseHelper.instance;
    List<FormData> response = await db.getAllData();
    this.setState(() {
      this.listData = response;
    });
    return response;
  }


  initState() {
    super.initState();
    _fetchCurrentLocation();

    this.getListViewData();

  }

  _fetchCurrentLocation() async {
    Map<String, double> location;
    // Platform messages may fail, so we use a try/catch PlatformException.

    try {
      location = await _location.getLocation;

      error = null;
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Permission denied';
      } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error = 'Permission denied - please ask the user to enable it from the app settings';
      }

      location = null;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    //if (!mounted) return;

    setState(() {
      _currentLocation = location;
    });
  }


  void showMap() {
    var _mapView = new MapView();

    CameraPosition cameraPosition;

    if (_currentLocation != null) {
      cameraPosition = new CameraPosition(new MapViewLocation.Location(_currentLocation["latitude"], _currentLocation["longitude"]), 14.0);
    } else {
      cameraPosition = new CameraPosition(new MapViewLocation.Location(12.9716, 77.5946), 14.0);
    }

    _mapView.show(
        new MapOptions(
            title: "Events",
            mapViewType: MapViewType.normal,
            showUserLocation: true,
            initialCameraPosition: cameraPosition),
        toolbarActions: [new ToolbarAction("Close", 1)]);

    _mapView.onMapReady.listen((location) {
//      MapViewLocation.Location currentLocation = new MapViewLocation.Location(currentLocation["latitude"], currentLocation["longitude"]);
//      _mapView.addMarker(new Marker(
//          "", "", currentLocation.latitude, currentLocation.longitude,
//          color: Colors.redAccent));
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

      LocationData locationData = new LocationData(marker.latitude.toString(),marker.longitude.toString());
      _mapView.dismiss();

      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => new TemplateListPage(locationData)));
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
      floatingActionButton: new FloatingActionButton(
        onPressed: showMap,

        backgroundColor: Colors.lightGreen,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: new AppBar(
        title: new Text(
          widget.title,
          style: new TextStyle(color: Colors.white),
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
                                  style: new TextStyle(
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
                            style: new TextStyle(color: AppColors.darkGreen),
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
                                  style: new TextStyle(
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
                            style: new TextStyle(color: AppColors.darkGreen),
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
                                    style: new TextStyle(
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
                            style: new TextStyle(color: AppColors.darkGreen),
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
                                    style: new TextStyle(
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
                            style: new TextStyle(color: AppColors.darkGreen),
                          ),
                        )
                      ],
                    )
                  ],
                )),
            new Expanded(
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
            )
          ],
        ),
      ),
    );
  }
}
