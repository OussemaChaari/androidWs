import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ipsas_jee/article_details.dart';
import 'package:ipsas_jee/model/product.dart';

class ArticlesView extends StatefulWidget {
  @override
  _ArticlesViewState createState() => _ArticlesViewState();
}

class _ArticlesViewState extends State<ArticlesView> {
  List<Product> products = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Mes articles'),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: getArticles,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                case ConnectionState.active:
                  return Center(child: CircularProgressIndicator());
                case ConnectionState.done:
                  if (snapshot.hasError) return Text(snapshot.error);
                  print(snapshot.data.body);
                  if (jsonDecode(snapshot.data.body).length == 0)
                    return Center(child: Text('No articles yet .'));
                  List productsMap = jsonDecode(snapshot.data.body);
                  productsMap.forEach((productMap) {
                    products.add(Product.fromJson(productMap));
                  });
                  return ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, int index) {
                      return GestureDetector(
                        onTap: () {
                          MaterialPageRoute _route = MaterialPageRoute(
                              builder: (context) =>
                                  ArticleDetails(products[index]));
                          Navigator.of(context).push(_route);
                        },
                        child: Card(
                          child: Container(
                            margin: EdgeInsets.all(24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(products[index].nameProd,
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 12.0),
                                    child: Image.network(
                                      'http://10.0.2.2:8989/ipsas-jee/images/${products[index].image}',
                                      height: 200,
                                      width: 200,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Padding(
                                      padding: EdgeInsets.only(bottom: 12),
                                      child: Text(products[index].definition)),
                                ),
                                Text(
                                  "Description : ",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(products[index].desc,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 16)),
                                Container(
                                  margin: EdgeInsets.only(top: 12, bottom: 12),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Icon(Icons.location_city),
                                          Text(
                                            products[index].localization,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          http
                                              .delete(
                                                  'http://10.0.2.2:8989/ipsas-jee/restWS/api/deleteProduct/' +
                                                      products[index]
                                                          .idProd
                                                          .toString())
                                              .then((onValue) {
                                            setState(() {});
                                            Scaffold.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                  'article deleted successfully!!'),
                                                  backgroundColor: Colors.green[700],
                                            ));
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
              }
            }));
  }

  Future get getArticles =>
      http.get('http://10.0.2.2:8989/ipsas-jee/restWS/api/getArticles');
}
