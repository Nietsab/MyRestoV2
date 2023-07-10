import 'package:flutter/material.dart';
import 'package:front/app/app.dart';
import 'package:front/app/tabs/detailProduct/detailProduct.dart';

final Map<String, WidgetBuilder> routes = {
  '/': (context) => App(),
  'detailProduct': (context) => DetailProduct(product: ModalRoute.of(context)!.settings.arguments),
};