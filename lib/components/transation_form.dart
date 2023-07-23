import 'dart:ffi';

import 'package:flutter/material.dart';

class TransationForm extends StatelessWidget {
  final TextEditingController _titleControler = TextEditingController();
  final TextEditingController _valueControler = TextEditingController();

  final void Function(String title, double value) _onSubmit;

  TransationForm({required onSubmit, super.key}) : _onSubmit = onSubmit;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          TextField(
            controller: _titleControler,
            decoration: const InputDecoration(
              labelText: 'Titulo',
            ),
          ),
          TextField(
            controller: _valueControler,
            decoration: const InputDecoration(
              labelText: 'Valor (R\$)',
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.purple,
            ),
            onPressed: () => {
              _onSubmit(_titleControler.text,
                  double.tryParse(_valueControler.text) ?? 0.0)
            },
            child: const Text('Nova Transação'),
          ),
        ]),
      ),
    );
  }
}
