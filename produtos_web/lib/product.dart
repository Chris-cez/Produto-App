import 'package:produtos_web/tools.dart';

class Product {
  int? id;
  String descricao;
  double preco;
  int estoque;
  DateTime? dataCriacao;

  Product({
    this.id,
    required this.descricao,
    required this.preco,
    required this.estoque,
    this.dataCriacao,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      descricao: json['descricao'],
      preco: json['preco'],
      estoque: json['estoque'],
      dataCriacao: json['dataCriacao'] != null ? DateTime.parse(json['dataCriacao']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'descricao': descricao,
      'preco': preco,
      'estoque': estoque,
      'dataCriacao': DateToDBDate(dataCriacao!.toIso8601String()),
    };
  }
}