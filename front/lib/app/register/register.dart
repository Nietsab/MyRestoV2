import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:front/app/app.dart';
import 'package:front/app/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../util/constants.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _loginController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  @override
  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    _lastNameController.dispose();
    _firstNameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    void postUserRegister(
        String user, 
        String password, 
        String lastName,
        String firstName,
        String email,
        String address
        ) async {
      SharedPreferences prefs = await SharedPreferences.getInstance() as SharedPreferences;
      var body = jsonEncode(<String, String>{
        'login': user,
        'password': password,
        'lastname': lastName,
        'firstname': firstName,
        'email': email,
        'address': address,
      });

      final url = Uri.parse(ApiConstants.baseUrl + ApiConstants.registerUser);

      final response = await http.post(
        url,
        body: body,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
      } else {
        print('Erreur lors de la création du compte : ${response.statusCode}');
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
                  'S\'inscrire',
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
                    SizedBox(height: 20),
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
                    TextField(
                      controller: _firstNameController,
                      decoration: InputDecoration(
                        hintText: 'Prénom',
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
                    TextField(
                      controller: _lastNameController,
                      decoration: InputDecoration(
                        hintText: 'Nom',
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
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'Email',
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
                    TextField(
                      controller: _addressController,
                      decoration: InputDecoration(
                        hintText: 'Adresse',
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
                        String lastName = _lastNameController.text;
                        String firstName = _firstNameController.text;
                        String email = _emailController.text;
                        String address = _addressController.text;
                        postUserRegister(
                            login, 
                            password,
                            lastName,
                            firstName,
                            email,
                            address
                        );
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
                        'S\'inscrire',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
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