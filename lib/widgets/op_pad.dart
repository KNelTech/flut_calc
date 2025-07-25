import 'package:flutter/material.dart';

typedef OperationPressed = void Function(String op);

class OpPad extends StatelessWidget {
  const OpPad({super.key, required this.onPressed});

  final OperationPressed onPressed;

  @override
  Widget build(BuildContext context) {
    const ops = ['+', '-', '×', '÷'];
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.spaceEvenly,
      children: ops
          .map(
            (op) => ElevatedButton(
              onPressed: () => onPressed(op),
              child: Text(op, style: const TextStyle(fontSize: 20)),
            ),
          )
          .toList(),
    );
  }
}
