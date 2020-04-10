import 'package:flutter/material.dart';

import '../models/image_model.dart';

class ImageList extends StatelessWidget {
  final List<ImageModel> imageList;

  ImageList(this.imageList);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, idx) {
        return buildImage(imageList[idx]);
      },
      itemCount: imageList.length,
    );
  }
}

Widget buildImage(ImageModel image) {
  return Container(
    margin: const EdgeInsets.all(20.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      border: Border.all(
        color: Colors.grey,
      ),
    ),
    child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            bottom: 8.0,
          ),
          child: Image.network(image.url),
        ),
        Text(image.title),
      ],
    ),
  );
}
