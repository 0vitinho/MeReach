import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mereachapp/controllers/serverController.dart';

void openModalBottomSheeet(BuildContext context) {
  final _formKey = GlobalKey<FormState>();
  String _userInput = 'https://';
  final serverController = Get.put(ServersController());

  showModalBottomSheet(
    context: context,
    builder: (BuildContext bc) {
      return Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: TextFormField(
                  initialValue: _userInput,
                  decoration: InputDecoration(
                    labelText: 'Url',
                  ),
                  onChanged: (value) {
                    _userInput = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O campo não pode ser vazio';
                    }
                    if(value == 'https://'){
                      return 'Insira uma url';
                    }
                    return null;
                  },
                ),
              ),
              TextButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    serverController.insertServer(_userInput);
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Url adicionada!')));
                    Navigator.pop(context);
                  }
                },
                child: Text('Adicionar Server'),
              ),
            ],
          ),
        ),
      );
    },
  );
}