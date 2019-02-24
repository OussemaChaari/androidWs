import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class AddArticle extends StatefulWidget {
  @override
  _AddArticleState createState() => _AddArticleState();
}

class _AddArticleState extends State<AddArticle> {
  String name, def, desc, image = '', localization;
  File file;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        TextField(
          onChanged: (prodName) => name = prodName,
          decoration: InputDecoration(hintText: 'Name'),
        ),
        TextField(
          onChanged: (prodName) => def = prodName,
          decoration: InputDecoration(hintText: 'Name'),
        ),
        TextField(
          onChanged: (prodName) => desc = prodName,
          decoration: InputDecoration(hintText: 'Description'),
        ),
        TextField(
          onChanged: (prodName) => localization = prodName,
          decoration: InputDecoration(hintText: 'Localization'),
        ),
        RaisedButton(
          child: Text('Add image'),
          onPressed: () async {
            file = await ImagePicker.pickImage(source: ImageSource.camera);
            image = file.path;
          },
        ),
        image != ''
            ? Image.file(
                file,
                height: 200,
                width: 200,
              )
            : Container(),
        RaisedButton(
          child: Text('Add product'),
          onPressed: () {
            Map<String, String> map = {
              'nameProd': name,
              'definition': def,
              'desc': desc,
              'localization': localization,
              'image': image
            };
            http.post('http://10.0.2.2:8989/ipsas-jee/restWS/api/addProduct',
                body: json.encode(map),
                headers: {'Content-Type': 'application/json'}).then((resp) {
              Navigator.of(context).pop();
            });
          },
        ),
      ],
    );
  }
}
