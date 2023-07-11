import 'dart:convert';
import 'package:front/app/model/foodCardModel.dart';
import 'package:shopping_cart/shopping_cart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../util/constants.dart';

class Cart extends StatelessWidget {
  final instance = ShoppingCart.getInstance<FoodCardModel>();

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> convertFoodCardModelToMap() {
      List<Map<String, dynamic>> cartItems = [];
      for (var item in instance.cartItems.toList()) {
        cartItems.add({
          'id': item.id,
          'name': item.name,
          'price': item.price,
          'quantity': item.quantity,
        });
      }
      return cartItems;
    }


    void postCommand() async {
      var cartItems = convertFoodCardModelToMap();
      print(jsonEncode(cartItems));
      final url = Uri.parse(ApiConstants.baseUrl + ApiConstants.postCommand);
      String basicAuth = 'Basic ${base64Encode(utf8.encode('admin:admin'))}';

      final response = await http.post(
        url,
        body: jsonEncode(cartItems),
        headers: {
          'Authorization' : basicAuth,
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        print('Commande envoyée');
      } else {
        print('Erreur lors de l\'envoi de la commande : ${response.statusCode}');
      }
    }

    return Scaffold(
      body: Center(
        child: Container(
          width: 350,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children:[
              ...instance.cartItems.map((e) => CartItem(
                index: e.id,
                imageSrc: 'null',
                title: e.name,
                price: '${e.price} €',
                quantity: e.quantity.toString()
              )).toList(),
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${instance.cartTotal} €',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  postCommand();
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFEEA734),
                  onPrimary: Colors.white,
                ),
                child: Text(
                  'Valider mon panier',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  final int index;
  final String imageSrc;
  final String title;
  final String price;
  final String quantity;

  const CartItem({
    required this.index,
    required this.imageSrc,
    required this.title,
    required this.price,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    final instance = ShoppingCart.getInstance<FoodCardModel>();

    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          // Image.asset(
          //   imageSrc,
          //   width: 160,
          //   height: 150,
          // ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                  ),
                ),
                Text(
                  price,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        var item = instance.findItemById(index);
                        instance.decrementItemQuantity(item);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                        ),
                        padding: EdgeInsets.all(10),
                        child: Icon(Icons.remove, color: Colors.white),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      quantity, // Remplacer par la valeur de la quantité
                      style: TextStyle(
                        fontFamily: 'Roboto',
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        var item = instance.findItemById(index);
                        instance.incrementItemQuantity(item);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFEEA734),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Icon(Icons.add, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}