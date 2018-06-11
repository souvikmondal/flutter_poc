final String columnName = "name";
final String columnEmail = "email";
final String columnMobile = "mobile";
final String columnAge = "age";
final String columnImagePath = "imagepath";
final String columnLocation = "location";

class FormData {
  String name;
  String email;
  String mobile;
  String age;
  String imagepath;
  String location;

  FormData();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      columnName: name,
      columnEmail: email,
      columnMobile: mobile,
      columnAge: age,
      columnImagePath: imagepath,
      columnLocation: location
    };

    return map;
  }

  FormData.fromMap(Map map) {
    name = map[columnName];
    email = map[columnEmail];
    mobile = map[columnMobile];
    age = map[columnAge];
    imagepath = map[columnImagePath];
    location = map[columnLocation];
  }
}
