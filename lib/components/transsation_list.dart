import 'package:expenses/models/transation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransationList extends StatelessWidget {
  final List<Transation> _transations;
  final void Function(String transationId) _onDelete;

  const TransationList(
      {required transations, required Function(String) onDelete, super.key})
      : _transations = transations,
        _onDelete = onDelete;

  Future<String?> _showDialog(BuildContext context, String transationId) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content:
            const Text('Você tem certeza que deseja excliuir está despesa?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Não'),
            child: const Text('Não'),
          ),
          TextButton(
            onPressed: () {
              _onDelete(transationId);
              Navigator.pop(context, 'Sim');
            },
            child: const Text('Sim'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _transations.isEmpty
        ? LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  SizedBox(
                    height: constraints.maxHeight * 0.05,
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.3,
                    child: Text("Nenhuma transação cadastrada!",
                        style: Theme.of(context).textTheme.titleMedium),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.05,
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      "assets/images/waiting.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: _transations.length,
            itemBuilder: (context, index) {
              final tr = _transations[index];

              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: FittedBox(child: Text("R\$${tr.value}")),
                    ),
                  ),
                  title: Text(
                    tr.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: Text(DateFormat('d MMM y').format(tr.date)),
                  trailing: IconButton(
                    onPressed: () => _showDialog(context, tr.id),
                    icon: const Icon(Icons.delete),
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              );
            },
          );
  }
}
