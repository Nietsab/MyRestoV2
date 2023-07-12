import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:front/util/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  List<Map<String, dynamic>> orderItems = [];

  @override
  void initState() {
    super.initState();
    fetchOrderItems(); // Appel de la fonction pour récupérer les données de l'API
  }

  Future<void> fetchOrderItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance() as SharedPreferences;

    final url = Uri.parse(ApiConstants.baseUrl + ApiConstants.getCommand);
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('${prefs.getString('auth')}'));
    final response = await http.get(url, headers : {
      'Authorization' : basicAuth,
      'Content-Type' : 'application/json',
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      setState(() {
        orderItems = [
          ...List<Map<String, dynamic>>.from(data),
        ];
      });
    } else {
      print('Erreur lors de la récupération des données : ${response.statusCode}');
    }
  }

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
                          orderItems.where((order) => order['status'] == 'PREPARE').length.toString(),
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
                      children: orderItems.map((order) {
                        if (order['status'] == 'PREPARE') {
                          return OrderItem(
                              orderNumber: order['id'].toString(),
                              customerName: '${order['user']['firstname']}  ${order['user']['lastname']}',
                              items: order['product'],
                              status: order['status']
                          );
                        } else {
                          return Container();
                        }
                      }).toList(),
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
                          orderItems.where((order) => order['status'] == 'SEND').length.toString(),
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
                      children:
                      orderItems.map((order) {
                          if (order['status'] == 'SEND') {
                            return OrderItem(
                                orderNumber: order['id'].toString(),
                                customerName: '${order['user']['firstname']}  ${order['user']['lastname']}',
                                items: order['product'],
                                status: order['status']
                            );
                          } else {
                            return Container();
                          }
                        }).toList(),
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
  final List<dynamic> items;
  final String status;

  const OrderItem({
    required this.orderNumber,
    required this.customerName,
    required this.items,
    required this.status,
  });

  void closeOrder(String orderId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance() as SharedPreferences;

    final url = Uri.parse(ApiConstants.baseUrl + ApiConstants.postCommand + '/${orderNumber}/send');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('${prefs.getString('auth')}'));

    final response = await http.post(url, headers : {
      'Authorization' : basicAuth,
      'Content-Type' : 'application/json',
    });

    if (response.statusCode == 200) {
      print('Commande ${orderNumber} fermée');
    } else {
      print('Erreur lors de la récupération des données : ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          children: [
            Text(
              'COMMANDE $orderNumber $customerName',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            status == 'PREPARE' ?
            IconButton(
                icon: Icon(Icons.close, color: Colors.red),
                onPressed: () {
                    closeOrder(orderNumber.toString() as String);
                }
            ) : Container(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: items.map((item) => Text(
                '${item['quantity']}x ${item['name']}',
              )).toList(),
            ),
          ]
        )
      ],
    );
  }
}