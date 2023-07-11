import 'package:flutter/material.dart';
import 'package:front/app/model/foodCardModel.dart';
import 'package:shopping_cart/shopping_cart.dart';

class FoodCard extends StatelessWidget {

  final double width;
  final Color primaryColor;
  final int productId;
  final String productUrl, productName, productPrice;


  FoodCard({
    required this.width,
    required this.primaryColor,
    required this.productId,
    required this.productUrl,
    required this.productName,
    required this.productPrice,
  });

  @override
  Widget build(BuildContext context) {
    final instance = ShoppingCart.getInstance<FoodCardModel>();

    return Container(
      width: width,
      color: Colors.white,
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 140.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(productUrl),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
              bottom: 4.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  productName,
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 4.0,
                          offset: Offset(3.0, 3.0),
                        )
                      ]),
                  child: IconButton(
                    icon: Icon(Icons.add, size: 17.0, color: primaryColor),
                    onPressed: () {
                      final item = FoodCardModel(name: productName, image: productUrl, id: productId, price: double.parse(productPrice));
                      instance.addItemToCart(item);
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '\$ $productPrice',
                  style: TextStyle(
                    fontSize: 13.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}