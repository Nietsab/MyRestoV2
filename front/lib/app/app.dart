import 'package:flutter/material.dart';
import 'package:front/app/model/foodCardModel.dart';
import 'package:front/app/order/order.dart';
import 'package:front/app/tabs/cart/cart.dart' as Cart;
import 'package:front/app/tabs/home/home.dart';
import 'package:front/app/tabs/card/card.dart' as CardFood;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_cart/shopping_cart.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  String isAdmin = 'false';

  @override
  void initState() {
    super.initState();
    checkAdminStatus();
  }

  void checkAdminStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String admin = prefs.getString('admin').toString();

    setState(() {
      isAdmin = admin;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ShoppingCart.init<FoodCardModel>();

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: TabBarView(
          children: <Widget>[
            Home(),
            CardFood.Card(),
            Cart.Cart(),
            Order(),
          ],
        ),
        bottomNavigationBar: Material(
          color: Colors.white,
          child: TabBar(
            labelPadding: const EdgeInsets.only(bottom: 10),
            labelStyle: TextStyle(fontSize: 16.0),
            indicatorColor: Colors.transparent,
            labelColor: theme.primaryColor,
            unselectedLabelColor: Colors.black54,
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.house, size: 28),
              ),
              Tab(
                icon: Icon(Icons.local_restaurant, size: 28),
              ),
              Tab(
                icon: Icon(Icons.shopping_cart, size: 28),
              ),
              Tab(
                icon: Icon(Icons.document_scanner, size: 28),
              ),
            ],
          ),
        ),
      ),
    );
  }
}