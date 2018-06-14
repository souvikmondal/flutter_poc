import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:poc/com/tarento/views/CameraPreviewScreen.dart';
import 'package:poc/com/tarento/views/ListScreen.dart';
import 'package:poc/com/tarento/views/home_page.dart';
import 'package:poc/data/databasehelper.dart';
import 'package:poc/model/formdata.dart';
import 'package:poc/model/locationdata.dart';

class Formscreen extends StatelessWidget {
   LocationData locationData;
   String title;

  Formscreen(this.locationData,  this.title);


  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: this.title,
      home: new FormPage(locationData,title),
      theme: new ThemeData(
          primarySwatch: Colors.green,
          brightness: Brightness.light,
          accentColor: Colors.red),
    );
  }
}

class FormPage extends StatefulWidget {
  LocationData locationData;
  String title;
  FormPage(this.locationData, this.title);

  @override
  _FormPageState createState() => new _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

  String _name, _email, _mobile, _age;
  String _imagePath = " ";
  String _mapLocation = " ";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      FormData data = new FormData();
      data.name = _name;
      data.email = _email;
      data.mobile = _mobile;
      data.age = _age;
      data.imagepath = _imagePath;
      data.latitude = widget.locationData.latitude;
      data.longitude = widget.locationData.longitude;
      var db = DatabaseHelper.instance;
      db.saveFormData(data).then((onValue) => _openListScreen());
    }
  }

  _openListScreen() {
    final snackbar = new SnackBar(
        content: new Text("Data Saved"));
    scaffoldKey.currentState.showSnackBar(snackbar);
//    Navigator.pop(context, "submit");

//  new Scaffold(new SnackBar(content: "Data Save"))
//    Navigator.push(
//        context, new MaterialPageRoute(builder: (context) => new ListScreen()));
  }


  _openCamera(BuildContext contfbext) async {
    List<CameraDescription> cameras;
    cameras = await availableCameras();
    final result = await Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new CameraPreviewScreen(cameras)));

    _imagePath = result;

    print("image path --->> $_imagePath");
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey,
      appBar: new AppBar(
        title: new Text(widget.title),
        backgroundColor: Colors.lightGreen,

      ),

      body: new Padding(
        padding: const EdgeInsets.all(20.0),
        child: new Form(
            key: formKey,
            child: new ListView(
              shrinkWrap: true,
              children: <Widget>[
                new TextFormField(
                  decoration: new InputDecoration(labelText: "Name"),
                  onSaved: (val) => _name = val,
                ),
                new TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: new InputDecoration(labelText: "Email"),
                  validator: (val) =>
                      !val.contains('@') ? 'Invalid Email' : null,
                  onSaved: (val) => _email = val,
                ),
                new TextFormField(
                  decoration: new InputDecoration(labelText: "Mobile number"),
                  maxLength: 10,
                  validator: (val) => val.length < 10
                      ? 'Mobile Number should be of 10 digits'
                      : null,
                  onSaved: (val) => _mobile = val,
                ),
                new TextFormField(
                  decoration: new InputDecoration(labelText: "Age"),
                  maxLength: 3,
                  onSaved: (val) => _age = val,
                ),
                new Text(_imagePath),
                new Text(_mapLocation),
                new Padding(padding: const EdgeInsets.only(top: 50.0)),
                //new FooterItems()
                new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    new IconButton(
                        icon: new Icon(Icons.camera),
                        onPressed: () {
                          _openCamera(context);
                        }),
                    new IconButton(
                        icon: new Icon(Icons.save), onPressed: _submit)
                  ],
                )
              ],
            )),
      ),
    );
  }
}
