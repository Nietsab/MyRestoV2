import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:front/app/model/foodCardModel.dart';
import 'package:shopping_cart/shopping_cart.dart';

class DetailProduct extends StatelessWidget {
  final product;
  const DetailProduct({required this.product});

  @override
  Widget build(BuildContext context) {
    final instance = ShoppingCart.getInstance<FoodCardModel>();
    String arrayBufferToBase64(List<int> arrayBuffer) {
      var bytes = Uint8List.fromList(arrayBuffer);
      var base64 = base64Encode(bytes);
      return base64;
    }

    if (product != null) {
      var listInt =  List<int>.from(product['image']);
      var base64 = arrayBufferToBase64(listInt);
      Uint8List bytes = base64Decode(base64);

      return Container(
        width: 400,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              product['name'] as String,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 250,
              width: 250,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: MemoryImage(bytes),
                ),
              )
            ),
            SizedBox(height: 10),
            Text(
              'Prix : ${product['price'].toString()} €',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Action à effectuer lors du clic sur le bouton
              },
              child: GestureDetector(
                onTap: () {
                  final item = FoodCardModel(
                      name: product['name'],
                      image: product['image'],
                      id: product['id'],
                      price: product['price'],
                  );
                 instance.addItemToCart(item);
                },
                child: Text(
                  'Ajouter au panier',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFEEA734),
                onPrimary: Colors.white,
                padding: EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                elevation: 3,
                shadowColor: Colors.black.withOpacity(0.24),
                minimumSize: Size(0, 40),
                alignment: Alignment.center,
              ),
            ),
          ],
        ),
      );
    } else {
      // Gérer le cas où les données du produit sont manquantes
      return Scaffold(
        body: Center(
          child: Text('Les détails du produit sont manquants'),
        ),
      );
    }

  }
}
