import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:front/app/login/login.dart';
import 'package:front/util/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../components/food_card.dart';

class Card extends StatefulWidget {
  @override
  _CardState createState() => _CardState();
}

class _CardState extends State<Card> {
  List<Map<String, dynamic>> foodList = [];
  SharedPreferences? prefs;

  Future<SharedPreferences> fetchSharedPreferences() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences;
  }

  Future<void> fetchCardData() async {
    final url = Uri.parse(ApiConstants.baseUrl + ApiConstants.getCard);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      setState(() {
        foodList = [
          ...List<Map<String, dynamic>>.from(data['entry']),
          ...List<Map<String, dynamic>>.from(data['main']),
          ...List<Map<String, dynamic>>.from(data['dessert']),
          ...List<Map<String, dynamic>>.from(data['drink']),
        ];
      });
    } else {
      print('Erreur lors de la récupération des données : ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchSharedPreferences().then((value) {
      setState(() {
        prefs = value;
      });
      fetchCardData();
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;

    String arrayBufferToBase64(List<int> arrayBuffer) {
      var bytes = Uint8List.fromList(arrayBuffer);
      var base64 = base64Encode(bytes);
      return base64;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Nos produits'),
        backgroundColor: Color(0xFFEEA734),
        actions: [
          IconButton(
            onPressed: () {
              if (prefs!.getString('auth') != null && prefs!.getString('admin') != null) {
                prefs!.remove('auth');
                prefs!.remove('admin');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              }
            },
            icon: Text(
              prefs!.getString('auth') != null ? 'Se déconnecter' : 'Se connecter',
              style: TextStyle(fontSize: 16),
            ),
            iconSize: 120,
          ),
        ],
      ),
      body: FutureBuilder<SharedPreferences>(
        future: fetchSharedPreferences(),
        builder: (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError || snapshot.data == null) {
            return Center(
              child: Text('Erreur lors de la récupération des données'),
            );
          }

          prefs = snapshot.data!;

          return SingleChildScrollView(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20.0,
                      left: 20.0,
                      right: 20.0,
                    ),
                  ),
                  Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 10.0,
                    runSpacing: 10.0,
                    children: foodList.map((product) {
                      var listInt = List<int>.from(product['image']);
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            'detailProduct',
                            arguments: product,
                          );
                        },
                        child: Hero(
                          tag: 'detail_food${foodList.indexOf(product)}',
                          child: FoodCard(
                            width: (size.width - 50.0) / 2,
                            primaryColor: theme.primaryColor,
                            productName: product['name']?.toString() ?? '',
                            productPrice: product['price']?.toString() ?? '',
                            productUrl: arrayBufferToBase64(listInt) ?? '',
                            productId: product['id'] ?? '',
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
