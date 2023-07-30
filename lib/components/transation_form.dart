import 'package:flutter/material.dart';

class TransationForm extends StatefulWidget {
  final void Function(String title, double value) _onSubmit;

  const TransationForm({required onSubmit, super.key}) : _onSubmit = onSubmit;

  @override
  State<TransationForm> createState() => _TransationFormState();
}

class _TransationFormState extends State<TransationForm> {
  final TextEditingController _titleControler = TextEditingController();
  final TextEditingController _valueControler = TextEditingController();

  _submitform() {
    final title = _titleControler.text;
    final value = double.tryParse(_valueControler.text) ?? 0.0;

    if (title.isEmpty || value <= 0) {
      return;
    }

    widget._onSubmit(
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
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Text('Nenhuma data selecionada!'),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  child: const Text('Selecionar Data'),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  // style: ElevatedButton.styleFrom(
                  //   foregroundColor: Theme.of(context).buttonTheme.colorScheme.
                  //   backgroundColor: Theme.of(context).colorScheme.primary,
                  // ),
                  onPressed: () => _submitform(),
                  child: const Text('Nova Transação'),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
