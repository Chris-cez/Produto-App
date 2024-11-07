import 'package:flutter/material.dart';
import 'package:produtos_web/product_form.dart';
import 'package:produtos_web/product_list.dart';
import 'package:produtos_web/product_view.dart';
import 'package:produtos_web/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProductProvider(
      child: MaterialApp(
        title: 'CRUD App',
        home: ProductList(),
        routes: {
          "/create" : (context) => ProductForm(),
          "/list" : (context) => ProductList(),
          "/view" : (context) => ProductView(),
        },
      ),
    );
  }
}
