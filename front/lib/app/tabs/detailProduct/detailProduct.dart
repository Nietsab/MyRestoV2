import 'package:flutter/material.dart';
import 'package:front/app/model/foodCardModel.dart';
import 'package:shopping_cart/shopping_cart.dart';

class DetailProduct extends StatelessWidget {
  final product;
  const DetailProduct({required this.product});

  @override
  Widget build(BuildContext context) {
    final instance = ShoppingCart.getInstance<FoodCardModel>();

    if (product != null) {

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
            // Image.asset(
            //   product['name'] as String,
            //   width: 250,
            //   height: 250,
            //   fit: BoxFit.cover,
            // ),
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
                      image: product['url'],
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
