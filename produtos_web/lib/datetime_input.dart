import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class BEtiqueta extends StatelessWidget{
  late final String? nome;
  late final bool foco;

  BEtiqueta({super.key, required this.nome, this.foco = false});
  
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          decoration:   BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: foco? 
              Theme.of(context).primaryColor :
              null
            ,
          ),
          padding: EdgeInsets.all(8.0),
          child: Text(
            nome ?? "",
            style: foco? 
              TextStyle(
                color: Theme.of(context).colorScheme.surface,
              ) :
              null
            ,
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class BData extends StatelessWidget{
  MaskedTextController controller = MaskedTextController(mask: '00/00/0000');
  late final String nome;
  late final bool editavel;
  late final Function(DateTime? inData) onSaved;
  late final Function(DateTime? inData) validator;

  BData({super.key, required this.nome, required this.onSaved, required this.validator, this.editavel = true, DateTime? inInicial}){
    if(inInicial != null){
      controller.text = TextoParaData(dateTimeParaTexto(inInicial))!;
    }
  }

  String? dateTimeParaTexto(DateTime? inData) {
    if(inData != null){
      return "${inData.year}-${inData.month.toString().padLeft(2, '0')}-${inData.day.toString().padLeft(2, '0')}";
    }else{
      return null;
    }
  }

  // ignore: non_constant_identifier_names
  DateTime? TextoParaDateTime(String? inTexto){
    if(inTexto != null){
      return DateTime(
        int.parse(inTexto.split("T")[0].split("-")[0]),
        int.parse(inTexto.split("T")[0].split("-")[1]),
        int.parse(inTexto.split("T")[0].split("-")[2]),
      );
    }else{
      return null;
    }
  }

  // ignore: non_constant_identifier_names
  String? TextoParaData(String? inTexto){
    if(inTexto != null){
      return "${inTexto.split("-")[2]}/${inTexto.split("-")[1]}/${inTexto.split("-")[0]}";
    }else{
      return null;
    }
  }

  // ignore: non_constant_identifier_names
  String? DataParaTexto(String? inTexto){
    if(inTexto != null){
      return "${inTexto.split("/")[2]}-${inTexto.split("/")[1]}-${inTexto.split("/")[0]}";
    }else{
      return null;
    }
  }

  DateTime? _valor(){
    try{
      return TextoParaDateTime(DataParaTexto(controller.text));
    }catch(erro){
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: editavel,
      controller: controller,
      decoration: InputDecoration(
        labelText: nome,
        hintText: '25/07/2004',
      ),
      keyboardType: TextInputType.number,
      onSaved: (value) => onSaved(_valor()),
      validator: (value) => validator(_valor()),
    );
  }
}