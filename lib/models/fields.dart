class Fields {
  DateTime date;
  String url;
  int total;
  String longitude;
  String latitude;

  Fields.fromMap(Map<String, dynamic> map): date = map['date'], 
    url = map['url'], total = map['total'], longitude = map['longitude'], latitude = map['latitude'];

  String get image {
    return url;
  }
  Fields({this.date, this.url, this.total, this.longitude, this.latitude});
}