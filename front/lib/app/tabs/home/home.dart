import 'package:flutter/material.dart';
import 'package:front/app/tabs/card/card.dart' as CardFood;

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/home.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(
                      'Passez des commandes pour une livraison rapide',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                      ),
                        textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Regardez les restaurants autour en ajoutant votre localisation',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Roboto',
                      ),
                        textAlign: TextAlign.center,
                    ),
                    Opacity(opacity: 0.9)
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CardFood.Card()));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFEEA734),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Container(
                      width: 140,
                      padding: EdgeInsets.all(8),
                      child: Text(
                        'Voir la carte',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Maintenant livré à ta porte 24/7',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Roboto',
                      fontSize: 12,
                    ),
                  ),
                    Opacity(opacity: 0.7)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
