import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ipsas_jee/model/product.dart';
import 'package:http/http.dart' as http;

class ArticleDetails extends StatefulWidget {
  final Product product;
  ArticleDetails(this.product);
  @override
  _ArticleDetailsState createState() => _ArticleDetailsState();
}

class _ArticleDetailsState extends State<ArticleDetails> {
  TextEditingController name, def, desc;

  @override
  void initState() {
    name = TextEditingController(text: widget.product.nameProd);
    def = TextEditingController(text: widget.product.definition);
    desc = TextEditingController(text: widget.product.desc);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Article details'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 48, horizontal: 24),
        child: ListView(
          shrinkWrap: false,
          children: <Widget>[
            SizedBox(height: 24),
            TextField(
              controller: name,
              decoration: InputDecoration(hintText: 'Name'),
            ),
            SizedBox(height: 24),
            TextField(
              decoration: InputDecoration(hintText: 'Definition'),
              controller: def,
            ),
            SizedBox(height: 24),
            TextField(
              controller: desc,
              decoration: InputDecoration(hintText: 'Description'),
            ),
            SizedBox(height: 24),
            RaisedButton(
              child: Text('Update', style: TextStyle(color: Colors.white)),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Product finalProd = widget.product;
                finalProd.nameProd = name.text;
                finalProd.definition = def.text;
                finalProd.desc = desc.text;
                http.put(
                    'http://10.0.2.2:8989/ipsas-jee/restWS/api/editProduct',
                    body: json.encode(finalProd.toJson()),
                    headers: {
                      'Content-Type': 'application/json'
                    }).then((onValue) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text('article Updated successfully!!'),
                    backgroundColor: Colors.green[700],
                  ));
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
