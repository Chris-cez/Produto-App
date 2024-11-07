import 'package:flutter/cupertino.dart';
import 'package:produtos_web/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductProvider extends InheritedWidget {
  final Widget child;
  List<Product> products = [];
  Product? productSelected;
  int? indexProduct;

  ProductProvider({
    required this.child,
  }) : super(child: child);

  static ProductProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ProductProvider>();
  }

  bool updateShouldNotify(ProductProvider oldWidget) {
    return true;
  }

  Future<void> fetchProducts() async {
    print(1);
    final response = await http.get(Uri.parse('http://localhost:3000/produtos'));
    if (response.statusCode == 200) {
      print(12);
      List<dynamic> data = json.decode(response.body);
      products = data.map((item) => Product.fromJson(item)).toList();
    } else {
      print(11);
      print(response.body);
      throw Exception('Failed to load products');
    }
    print(11);
  }

  Future<void> addProduct(Product product) async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/produtos'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(product.toJson()),
    );
    print('Request body: ${json.encode(product.toJson())}');
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 201) {
      products.add(Product.fromJson(json.decode(response.body)));
    } else {
      throw Exception('Failed to add product');
    }
  }

  Future<void> updateProduct(Product product) async {
    final response = await http.put(
      Uri.parse('http://localhost:3000/produtos/${product.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(product.toJson()),
    );
    if (response.statusCode == 200) {
      int index = products.indexWhere((p) => p.id == product.id);
      if (index != -1) {
        products[index] = Product.fromJson(json.decode(response.body));
      }
    } else {
      throw Exception('Failed to update product');
    }
  }

  Future<void> deleteProduct(int id) async {
    final response = await http.delete(Uri.parse('http://localhost:3000/produtos/$id'));
    if (response.statusCode == 200) {
      products.removeWhere((product) => product.id == id);
    } else {
      throw Exception('Failed to delete product');
    }
  }
}