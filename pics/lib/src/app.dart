import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './models/image_model.dart';
import './widgets/image_list.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int counter = 1;
  List<ImageModel> images = [];

  Future<String> fetchImage() async {
    final url = 'http://jsonplaceholder.typicode.com/photos/$counter';
    final response = await http.get(url);
    final imgModel = ImageModel.fromJson(json.decode(response.body));
    setState(() {
      images.add(imgModel);
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Let\'s see some images')),
        floatingActionButton: FloatingActionButton(
          onPressed: fetchImage,
          child: Icon(Icons.add),
        ),
        body: ImageList(images),
      ),
    );
  }
}
