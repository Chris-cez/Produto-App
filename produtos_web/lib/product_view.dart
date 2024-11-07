import 'package:flutter/material.dart';
import 'package:produtos_web/datetime_input.dart';
import 'package:produtos_web/field_form.dart';
import 'package:produtos_web/product.dart';
import 'package:produtos_web/provider.dart';

class ProductView extends StatelessWidget {
  ProductView({super.key});

  String title = 'Visualizar';
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime? data;

  TextEditingController idController = TextEditingController();
  TextEditingController descricaoController = TextEditingController();
  TextEditingController precoController = TextEditingController();
  TextEditingController estoqueController = TextEditingController();
  TextEditingController dataCadastroController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = ProductProvider.of(context) as ProductProvider;

    int? index;

    if (productProvider.indexProduct != null) {
      index = productProvider.indexProduct;
      descricaoController.text = productProvider.productSelected!.descricao;
      precoController.text = productProvider.productSelected!.preco.toString();
      estoqueController.text = productProvider.productSelected!.estoque.toString();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
        actions: [
          Container(
            child: TextButton(
              child: Text('Product List'),
              onPressed: () {
                Navigator.popAndPushNamed(context, "/list");
              },
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            margin: EdgeInsets.all(8),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                FieldForm(
                  controller: descricaoController,
                  isForm: false,
                  label: 'Descrição',
                ),
                FieldForm(
                  controller: precoController,
                  isForm: false,
                  label: 'Preço',
                ),
                FieldForm(
                  controller: estoqueController,
                  label: 'Estoque',
                  isForm: false,
                ),
                BData(
                  editavel: false,
                  nome: "Data de Cadastro",
                  onSaved: (DateTime? inData) {
                    data = inData;
                  },
                  validator: (DateTime? inData) {
                    if (inData == null) {
                      return 'Data inválida';
                    }
                    return null;
                  },
                ),
                TextButton(
                  onPressed: () {
                    Navigator.popAndPushNamed(context, "/create");
                  },
                  child: Text('Editar'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Delete Product'),
                          content: Text('Do you want to delete this product?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () async {
                                await productProvider.deleteProduct(productProvider.productSelected!.id!);
                                Navigator.popAndPushNamed(context, "/list");
                              },
                              child: Text('Delete'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text('Delete'),
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.red),
                    foregroundColor: WidgetStatePropertyAll(Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}