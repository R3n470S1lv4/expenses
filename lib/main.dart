import 'package:expenses/components/transation_form.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:expenses/components/transsation_list.dart';
import 'package:expenses/models/transation.dart';
import 'package:expenses/components/transation_amount.dart';

main() => runApp(const ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final grafico = const Card(
    color: Colors.cyan,
    elevation: 5,
    child: Text("Grafico"),
  );

  final _transations = [
    Transation(
        id: 't1',
        title: 'novo tenis de corrida',
        value: 310.76,
        date: DateTime.now()),
    Transation(
      id: 't2',
      title: 'conta de luz',
      value: 211.30,
      date: DateTime.now(),
    ),
  ];

  _addTransation(String title, double value) {
    final transasion = Transation(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: DateTime.now(),
    );

    setState(() {
      _transations.add(transasion);
    });
  }

  _openTransationFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransationForm(onSubmit: _addTransation);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Despesas Pessoais"),
        actions: [
          IconButton(
            onPressed: () => _openTransationFormModal(context),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            grafico,
            TransationList(transations: _transations),
            TransationAmount(
              value: _transations.map((tr) => tr.value).reduce((a, b) => a + b),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openTransationFormModal(context),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
