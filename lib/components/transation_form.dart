import 'dart:ffi';

import 'package:flutter/material.dart';

class TransationForm extends StatelessWidget {
  final TextEditingController _titleControler = TextEditingController();
  final TextEditingController _valueControler = TextEditingController();

  final void Function(String title, double value) _onSubmit;

  TransationForm({required onSubmit, super.key}) : _onSubmit = onSubmit;

  _submitform() {
    final title = _titleControler.text;
    final value = double.tryParse(_valueControler.text) ?? 0.0;

    if (title.isEmpty || value <= 0) {
      return;
    }

    _onSubmit(
      title,
      value,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          TextField(
            controller: _titleControler,
            onSubmitted: (_) => _submitform(),
            decoration: const InputDecoration(
              labelText: 'Titulo',
            ),
          ),
          TextField(
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onSubmitted: (_) => _submitform(),
            controller: _valueControler,
            decoration: const InputDecoration(
              labelText: 'Valor (R\$)',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.purple,
              ),
              onPressed: () => _submitform(),
              child: const Text('Nova Transação'),
            ),
          ),
        ]),
      ),
    );
  }
}
