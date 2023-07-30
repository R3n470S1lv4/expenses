import 'package:expenses/components/chart.dart';
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
    final ThemeData theme = ThemeData();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: Colors.purple,
          secondary: Colors.amber,
        ),
        textTheme: theme.textTheme.copyWith(
          titleLarge: const TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          titleMedium: const TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          labelMedium: const TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
        )),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transation> _transations = [
    Transation(
      id: 't0',
      title: 'conta antiga',
      value: 14,
      date: DateTime.now().subtract(const Duration(days: 33)),
    ),
    Transation(
      id: 't1',
      title: 'novo tenis de corrida',
      value: 310.76,
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Transation(
      id: 't2',
      title: 'conta de luz',
      value: 211.30,
      date: DateTime.now().subtract(const Duration(days: 4)),
    ),
    Transation(
      id: 't3',
      title: 'carto de credito',
      value: 1000,
      date: DateTime.now(),
    ),
    Transation(
      id: 't4',
      title: 'lanche',
      value: 11.30,
      date: DateTime.now().subtract(const Duration(days: 4)),
    ),
  ];

  List<Transation> get _recentTransations {
    return _transations
        .where((tr) =>
            tr.date.isAfter(DateTime.now().subtract(const Duration(days: 7))))
        .toList();
  }

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

    Navigator.of(context).pop();
  }

  _openTransationFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransationForm(onSubmit: _addTransation);
        });
  }

  _calculeteAmount() {
    if (_transations.isEmpty) {
      return 0.0;
    }
    return _transations.map((tr) => tr.value).reduce((a, b) => a + b);
  }

  _deleteExpense(int index) {
    setState(() {
      _transations.removeAt(index);
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
            Chart(recentTransations: _recentTransations),
            TransationList(
              transations: _transations,
              onDelete: _deleteExpense,
            ),
            TransationAmount(value: _calculeteAmount()),
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
