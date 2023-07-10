import 'package:flutter/material.dart';

class Order extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 325,
                margin: EdgeInsets.only(top: 80),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 8,
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          'COMMANDE EN COURS',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                            textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        Text(
                          '50',
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.green,
                          ),
                            textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: 325,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 8,
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        OrderItem(
                          orderNumber: 'n°1515454',
                          customerName: 'Julien Peira',
                          items: [
                            '1x Mousse au chocolat',
                            '1x Burger frite',
                            '1x Coca Cola',
                          ],
                        ),
                        Divider(),
                        OrderItem(
                          orderNumber: 'n°1515454',
                          customerName: 'Julien Peira',
                          items: [
                            '1x Mousse au chocolat',
                            '1x Burger frite',
                            '1x Coca Cola',
                          ],
                        ),
                        Divider(),
                        OrderItem(
                          orderNumber: 'n°1515454',
                          customerName: 'Julien Peira',
                          items: [
                            '1x Mousse au chocolat',
                            '1x Burger frite',
                            '1x Coca Cola',
                          ],
                        ),
                        Divider(),
                        OrderItem(
                          orderNumber: 'n°1515454',
                          customerName: 'Julien Peira',
                          items: [
                            '1x Mousse au chocolat',
                            '1x Burger frite',
                            '1x Coca Cola',
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              SizedBox(height: 40),
              Container(
                width: 325,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 8,
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          'COMMANDE PASSÉES',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                            textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        Text(
                          '50',
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.red,
                          ),
                            textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Container(
                width: 325,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 8,
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        OrderItem(
                          orderNumber: 'n°1515454',
                          customerName: 'Julien Peira',
                          items: [
                            '1x Mousse au chocolat',
                            '1x Burger frite',
                            '1x Coca Cola',
                          ],
                        ),
                        Divider(),
                        OrderItem(
                          orderNumber: 'n°1515454',
                          customerName: 'Julien Peira',
                          items: [
                            '1x Mousse au chocolat',
                            '1x Burger frite',
                            '1x Coca Cola',
                          ],
                        ),
                        Divider(),
                        OrderItem(
                          orderNumber: 'n°1515454',
                          customerName: 'Julien Peira',
                          items: [
                            '1x Mousse au chocolat',
                            '1x Burger frite',
                            '1x Coca Cola',
                          ],
                        ),
                        Divider(),
                        OrderItem(
                          orderNumber: 'n°1515454',
                          customerName: 'Julien Peira',
                          items: [
                            '1x Mousse au chocolat',
                            '1x Burger frite',
                            '1x Coca Cola',
                          ],
                        ),
                        Divider(),
                        OrderItem(
                          orderNumber: 'n°1515454',
                          customerName: 'Julien Peira',
                          items: [
                            '1x Mousse au chocolat',
                            '1x Burger frite',
                            '1x Coca Cola',
                          ],
                        ),
                        Divider(),
                        OrderItem(
                          orderNumber: 'n°1515454',
                          customerName: 'Julien Peira',
                          items: [
                            '1x Mousse au chocolat',
                            '1x Burger frite',
                            '1x Coca Cola',
                          ],
                        ),
                      ],
                    ),
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

class OrderItem extends StatelessWidget {
  final String orderNumber;
  final String customerName;
  final List<String> items;

  const OrderItem({
    required this.orderNumber,
    required this.customerName,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'COMMANDE $orderNumber $customerName',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items.map((item) => Text(item)).toList(),
        ),
      ],
    );
  }
}