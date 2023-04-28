import 'package:contact_crud_hive/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormContactFielder extends StatelessWidget {
  TextEditingController controller;
  String hintTextName;
  IconData iconData;
  TextInputType textInputType;

  FormContactFielder({
    super.key,
    required this.controller,
    required this.hintTextName,
    required this.iconData,
    this.textInputType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        icon: Icon(iconData),
        hintText: hintTextName,
        filled: true,
      ),
      keyboardType: textInputType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por Favor Digite $hintTextName';
        }
        if (hintTextName == 'Email' && !validateEmail(value)) {
          return 'Digite um Email Válido';
        }
        if (hintTextName == 'Nome' && !filtroLetrasNome(value)) { //
          return 'Digite apenas letras no campo!';
        }
        if (hintTextName == 'Código' && !filtroNumerosCodigo(value)) { // 
          return 'Digite apenas números no campo!';
        }
      },
    );
  }

  bool filtroLetrasNome(String value) { // nova função para permitir somente letras no nome
    return RegExp(r'^[a-zA-Z]+$').hasMatch(value);
  }

  bool filtroNumerosCodigo(String value) {  // nova função para permitir somente numeros no codigo do contato
    return RegExp(r'^[0-9]+$').hasMatch(value);
  }
}

validateEmail(String email) {
  final emailReg = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  return emailReg.hasMatch(email);
}

