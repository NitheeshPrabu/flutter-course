class ImageModel {
  String url;
  String title;
  int id;

  ImageModel({this.url, this.title, this.id});

  // named constructor
  ImageModel.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    url = parsedJson['url'];
    title = parsedJson['title'];
  }

  // ImageModel.fromJsonShortForm(Map<String, dynamic> parsedJson)
  //     : id = parsedJson['id'],
  //       url = parsedJson['url'],
  //       title = parsedJson['title'];
}
