import 'package:flutter/material.dart';
// import 'package:front/app/tabs/account/account.dart';
// import 'package:front/app/tabs/cart/cart.dart';
import 'package:front/app/tabs/home/home.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: TabBarView(
          children: <Widget>[
            Home(),
            // Cart(),
            // Account(),
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
                icon: Icon(Icons.home, size: 28),
              ),
              Tab(
                icon: Icon(Icons.shopping_cart, size: 28),
              ),
              Tab(
                icon: Icon(Icons.local_restaurant, size: 28),
              ),
              Tab(
                icon: Icon(Icons.person_outline, size: 28),
              ),
            ],
          ),
        ),
      ),
    );
  }
}