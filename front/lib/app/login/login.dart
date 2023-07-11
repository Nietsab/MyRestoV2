import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:front/app/app.dart';
import 'package:front/app/register/register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../util/constants.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _loginController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    void postUserLogin(String user, String password) async {
      SharedPreferences prefs = await SharedPreferences.getInstance() as SharedPreferences;

      final url = Uri.parse(ApiConstants.baseUrl + ApiConstants.loginUser);
      String basicAuth = 'Basic ${base64Encode(utf8.encode('$user:$password'))}';

      final response = await http.post(
        url,
        headers: {
          'Authorization' : basicAuth,
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        prefs.setString('auth', '$user:$password');
        print(responseData['admin']);
        prefs.setString('admin', responseData['admin'].toString());
        Navigator.push(context, MaterialPageRoute(builder: (context) => App()));
      } else {
        print('Erreur lors de la connexion : ${response.statusCode}');
      }
    }

    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/login.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            width: 300,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Connexion',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Roboto',
                  ),
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    TextField(
                      controller: _loginController,
                      decoration: InputDecoration(
                        hintText: 'Nom utilisateur',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.all(10),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Mot de passe',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.all(10),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        String login = _loginController.text;
                        String password = _passwordController.text;
                        postUserLogin(login, password);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFEEA734),
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: EdgeInsets.all(10),
                        elevation: 8,
                      ),
                      child: Text(
                        'Connexion',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
                      },
                      child: Text(
                        'Pas encore de compte ?',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Roboto',
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
