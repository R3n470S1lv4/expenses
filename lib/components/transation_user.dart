import 'dart:math';

import 'package:expenses/components/transation_form.dart';
import 'package:expenses/components/transsation_list.dart';
import 'package:flutter/material.dart';
import 'package:expenses/models/transation.dart';

class TransationUser extends StatefulWidget {
  const TransationUser({super.key});

  @override
  State<TransationUser> createState() => _TransationUserState();
}

class _TransationUserState extends State<TransationUser> {
  final titleControler = TextEditingController();
  final valueControler = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransationList(transations: _transations),
        TransationForm(onSubmit: _addTransation),
      ],
    );
  }
}
