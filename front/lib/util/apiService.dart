import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:front/util/constants.dart';

class ApiService {
  Future registerUser(String body) async {
    try {
      var response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.registerUser),
        body: body,
      );

      return response;
    } catch (e) {
      log(e.toString());
    }
  }

  Future loginUser(String body) async {
    try {
      var response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.loginUser),
        body: body,
      );

      return response;
    } catch (e) {
      log(e.toString());
    }
  }

  Future getCard() async {
    try {
      var response = await http.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.getCard),
      );

      return response;
    } catch (e) {
      log(e.toString());
    }
  }

  Future postCommand(String body) async {
    try {
      var response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.postCommand),
        body: body,
      );

      return response;
    } catch (e) {
      log(e.toString());
    }
  }

  Future getCommand() async {
    try {
      var response = await http.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.getCommand),
      );

      return response;
    } catch (e) {
      log(e.toString());
    }
  }

  Future sendCommand(String id) async {
    try {
      var response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.sendCommand + id),
      );

      return response;
    } catch (e) {
      log(e.toString());
    }
  }
}