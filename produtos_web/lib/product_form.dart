import 'package:flutter/material.dart';
import 'package:produtos_web/datetime_input.dart';
import 'package:produtos_web/field_form.dart';
import 'package:produtos_web/product.dart';
import 'package:produtos_web/provider.dart';

class ProductForm extends StatefulWidget {
  const ProductForm({super.key});

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  String title = 'Cadastrar';
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
      data = productProvider.productSelected!.dataCriacao;
      dataCadastroController.text = data != null ? "${data!.day}/${data!.month}/${data!.year}" : "";

      setState(() {
        this.title = 'Alterar';
      });
    }

    void save() async {
      if (formKey.currentState!.validate()) {
        formKey.currentState?.save();
        Product product = Product(
          descricao: descricaoController.text,
          preco: double.parse(precoController.text),
          estoque: int.parse(estoqueController.text),
          dataCriacao: data,
        );

        if (index != null) {
          product.id = productProvider.productSelected!.id;
          await productProvider.updateProduct(product);
        } else {
          await productProvider.addProduct(product);
        }

        Navigator.popAndPushNamed(context, "/list");
      }
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
                  label: 'Descrição',
                ),
                FieldForm(
                  controller: precoController,
                  label: 'Preço',
                ),
                FieldForm(
                  controller: estoqueController,
                  label: 'Estoque',
                ),
                BData(
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
                  inInicial: data, // Adicione esta linha para preencher a data inicial
                ),
                TextButton(
                  onPressed: save,
                  child: Text('Salvar'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
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
