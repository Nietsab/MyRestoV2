import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:front/util/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../components/food_card.dart';

class Card extends StatefulWidget {
  @override
  _CardState createState() => _CardState();
}

class _CardState extends State<Card> {
  List<Map<String, dynamic>> foodList = [];

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
    fetchCardData();
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
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                bottom: 10.0,
                top: 35.0,
              ),
              child: Text(
                'Nos produits',
                style: TextStyle(fontSize: 21.0),
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
                      width: (size.width - 50.0) / 2, // Ajustez la largeur selon vos besoins
                      primaryColor: theme.primaryColor,
                      productName: product['name']?.toString() ?? '',
                      productPrice: product['price']?.toString() ?? '',
                      productUrl: arrayBufferToBase64(listInt) ?? '',
                      productId: product['id'] ?? '',
                    ),
                  ),
                );
              },).toList()
            ),
          ],
        ),
      ),
    );
  }
}
