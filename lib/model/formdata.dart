final String columnName = "name";
final String columnEmail = "email";
final String columnMobile = "mobile";
final String columnAge = "age";
final String columnImagePath = "imagepath";
final String columnLatitude = "latitude";
final String columnLongitude = "longitude";

class FormData {
  String name;
  String email;
  String mobile;
  String age;
  String imagepath;
  String latitude;
  String longitude;

  FormData();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      columnName: name,
      columnEmail: email,
      columnMobile: mobile,
      columnAge: age,
      columnImagePath: imagepath,
      columnLatitude:latitude,
      columnLongitude:longitude
    };

    return map;
  }

  FormData.fromMap(Map map) {
    name = map[columnName];
    email = map[columnEmail];
    mobile = map[columnMobile];
    age = map[columnAge];
    imagepath = map[columnImagePath];
    latitude = map[columnLatitude];
    longitude=map[columnLongitude];
  }
}
