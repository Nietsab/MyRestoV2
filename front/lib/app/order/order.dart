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
  bool isLoading = false;
  String successMessage = '';
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchOrderItems(); // Appel de la fonction pour récupérer les données de l'API
  }

  Future<void> fetchOrderItems() async {
    setState(() {
      isLoading = true; // Afficher l'indicateur de chargement
      successMessage = ''; // Réinitialiser le message de succès
      errorMessage = ''; // Réinitialiser le message d'erreur
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();

    final url = Uri.parse(ApiConstants.baseUrl + ApiConstants.getCommand);
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('${prefs.getString('auth')}'));
    final response = await http.get(url, headers: {
      'Authorization': basicAuth,
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      setState(() {
        orderItems = [
          ...List<Map<String, dynamic>>.from(data),
        ];
        isLoading = false; // Cacher l'indicateur de chargement
      });
    } else {
      print('Erreur lors de la récupération des données : ${response.statusCode}');
      setState(() {
        isLoading = false; // Cacher l'indicateur de chargement
        errorMessage = 'Erreur lors de la récupération des données';
      });
    }
  }

  void closeOrder(String orderId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final url = Uri.parse(ApiConstants.baseUrl + ApiConstants.postCommand + '/$orderId/send');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('${prefs.getString('auth')}'));
    final response = await http.post(url, headers: {
      'Authorization': basicAuth,
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      print('Commande $orderId fermée');
      setState(() {
        successMessage = 'Commande $orderId fermée avec succès';
        errorMessage = '';
      });
      refreshOrders(); // Appeler la fonction refreshOrders pour mettre à jour la liste des commandes
    } else {
      print('Erreur lors de la fermeture de la commande : ${response.statusCode}');
      setState(() {
        successMessage = '';
        errorMessage = 'Erreur lors de la fermeture de la commande';
      });
    }
  }

  void refreshOrders() {
    setState(() {
      fetchOrderItems(); // Rafraîchir le composant après avoir fermé une commande
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Administration'),
        backgroundColor: Color(0xFFEEA734),
      ),
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
                      children: [
                        if (isLoading) // Afficher l'indicateur de chargement
                          CircularProgressIndicator(),
                        ...orderItems.map((order) {
                          if (order['status'] == 'PREPARE') {
                            return Column(
                              children: [
                                OrderItem(
                                  orderNumber: order['id'].toString(),
                                  customerName: '${order['user']['firstname']}  ${order['user']['lastname']}',
                                  items: order['product'],
                                  status: order['status'],
                                  closeOrder: closeOrder, // Passer la fonction closeOrder
                                  refreshOrders: refreshOrders, // Passer la fonction refreshOrders
                                ),
                                SizedBox(height: 10), // Espace entre chaque commande
                              ],
                            );
                          } else {
                            return Container();
                          }
                        }).toList(),
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
                      children: [
                        ...orderItems.map((order) {
                          if (order['status'] == 'SEND') {
                            return Column(
                              children: [
                                OrderItem(
                                  orderNumber: order['id'].toString(),
                                  customerName: '${order['user']['firstname']}  ${order['user']['lastname']}',
                                  items: order['product'],
                                  status: order['status'],
                                  closeOrder: closeOrder, // Passer la fonction closeOrder
                                  refreshOrders: refreshOrders, // Passer la fonction refreshOrders
                                ),
                                SizedBox(height: 10), // Espace entre chaque commande
                              ],
                            );
                          } else {
                            return Container();
                          }
                        }).toList(),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              if (successMessage.isNotEmpty) // Afficher le message de succès
                Text(
                  successMessage,
                  style: TextStyle(color: Colors.green),
                ),
              if (errorMessage.isNotEmpty) // Afficher le message d'erreur
                Text(
                  errorMessage,
                  style: TextStyle(color: Colors.red),
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
  final Function(String) closeOrder; // Ajouter la signature de la fonction closeOrder
  final Function refreshOrders; // Ajouter la signature de la fonction refreshOrders

  const OrderItem({
    required this.orderNumber,
    required this.customerName,
    required this.items,
    required this.status,
    required this.closeOrder, // Ajouter la fonction closeOrder comme paramètre
    required this.refreshOrders, // Ajouter la fonction refreshOrders comme paramètre
  });

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
            status == 'PREPARE'
                ? IconButton(
              icon: Icon(Icons.close, color: Colors.red),
              onPressed: () {
                closeOrder(orderNumber); // Appeler la fonction closeOrder avec l'ID de la commande
              },
            )
                : Container(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: items.map((item) => Text(
                '${item['quantity']}x ${item['name']}',
              )).toList(),
            ),
          ],
        ),
      ],
    );
  }
}
