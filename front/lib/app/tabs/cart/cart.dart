import 'dart:convert';
import 'dart:typed_data';
import 'package:front/app/model/foodCardModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_cart/shopping_cart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../util/constants.dart';
import '../../login/login.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  final instance = ShoppingCart.getInstance<FoodCardModel>();
  late SharedPreferences prefs;
  bool isCommandSent = false;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    fetchSharedPreferences();
  }

  Future<void> fetchSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

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

  Future<void> postCommand() async {
    var cartItems = convertFoodCardModelToMap();
    final url = Uri.parse(ApiConstants.baseUrl + ApiConstants.postCommand);
    String basicAuth = 'Basic ${base64Encode(utf8.encode('${prefs.get('auth')}'))}';

    final response = await http.post(
      url,
      body: jsonEncode(cartItems),
      headers: {
        'Authorization': basicAuth,
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      print('Commande envoyée');
      instance.clearCart();
      setState(() {
        isCommandSent = true;
        isError = false;
      }); // Rafraîchir le composant
    } else {
      print('Erreur lors de l\'envoi de la commande : ${response.statusCode}');
      setState(() {
        isCommandSent = true;
        isError = true;
      }); // Rafraîchir le composant
    }
  }

  String arrayBufferToBase64(List<int> arrayBuffer) {
    var bytes = Uint8List.fromList(arrayBuffer);
    var base64 = base64Encode(bytes);
    return base64;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          prefs = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: Text('Panier'),
              backgroundColor: Color(0xFFEEA734),
              actions: [
                IconButton(
                  onPressed: () {
                    if (prefs.getString('auth') != null && prefs.getString('admin') != null) {
                      prefs.remove('auth');
                      prefs.remove('admin');
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
                    prefs.getString('auth') != null ? 'Se déconnecter' : 'Se connecter',
                    style: TextStyle(fontSize: 16),
                  ),
                  iconSize: 120,
                ),
              ],
            ),
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
                  children: [
                    ...instance.cartItems.map((e) => CartItem(
                      index: e.id,
                      imageSrc: e.image,
                      title: e.name,
                      price: '${e.price} €',
                      quantity: e.quantity.toString(),
                      refreshCart: () {
                        setState(() {}); // Rafraîchir le composant
                      },
                    )),
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
                      onPressed: () async {
                        if (instance.cartItems.length > 0) {
                          if (prefs.getString('auth') != null) {
                            await postCommand();
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LoginPage()),
                            );
                          }
                        } else {
                          return null;
                        }
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
                    if (isCommandSent)
                      Text(
                        isError ? 'Une erreur serveur est survenue' : 'La commande a été envoyée avec succès',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          color: isError ? Colors.red : Colors.green,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

class CartItem extends StatelessWidget {
  final int index;
  final String imageSrc;
  final String title;
  final String price;
  final String quantity;
  final VoidCallback refreshCart;

  const CartItem({
    required this.index,
    required this.imageSrc,
    required this.title,
    required this.price,
    required this.quantity,
    required this.refreshCart,
  });

  @override
  Widget build(BuildContext context) {
    final instance = ShoppingCart.getInstance<FoodCardModel>();
    Uint8List bytes = base64Decode(imageSrc);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          Container(
              width: 160,
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: MemoryImage(bytes),
                ),
              )),
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
                        refreshCart(); // Mettre à jour le composant parent
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
                      quantity,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        var item = instance.findItemById(index);
                        instance.incrementItemQuantity(item);
                        refreshCart(); // Mettre à jour le composant parent
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
