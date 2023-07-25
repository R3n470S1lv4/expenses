import 'package:flutter/material.dart';

class TransationAmount extends StatelessWidget {
  final double _value;

  const TransationAmount({required value, super.key}) : _value = value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Total ${_value.toStringAsFixed(2)}",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
