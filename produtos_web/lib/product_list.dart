import 'package:flutter/material.dart';
import 'package:produtos_web/product.dart';
import 'package:produtos_web/provider.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = ProductProvider.of(context) as ProductProvider;

    return Scaffold(
      appBar: AppBar(
        title: Text("Listagem dos produtos"),
        actions: [
          IconButton(
            onPressed: () {
              productProvider.productSelected = null;
              productProvider.indexProduct = null;
              Navigator.popAndPushNamed(context, "/create");
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: productProvider.fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar produtos'));
          } else {
            return ListView.builder(
              itemCount: productProvider.products.length,
              itemBuilder: (BuildContext contextBuilder, indexBuilder) => Container(
                child: ListTile(
                  title: Text(productProvider.products[indexBuilder].descricao),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          productProvider.productSelected = productProvider.products[indexBuilder];
                          productProvider.indexProduct = indexBuilder;
                          Navigator.popAndPushNamed(context, "/create");
                        },
                        icon: Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {
                          productProvider.productSelected = productProvider.products[indexBuilder];
                          productProvider.indexProduct = indexBuilder;
                          Navigator.popAndPushNamed(context, "/view");
                        },
                        icon: Icon(Icons.visibility, color: Colors.blue),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 0.3),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}