import 'package:flutter/material.dart';
import '../services/fraction_service.dart';
import '../widgets/op_pad.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _aCtrl = TextEditingController();
  final _bCtrl = TextEditingController();
  final _denoms = const [2, 4, 8, 16, 32];

  int _snapDen = 16;
  String _result = '';

  void _onOp(String op) {
    try {
      final a = Fraction.parse(_aCtrl.text);
      final b = Fraction.parse(_bCtrl.text);
      Fraction res;

      switch (op) {
        case '+':
          res = a + b;
          break;
        case '-':
          res = a - b;
          break;
        case '×':
          res = a * b;
          break;
        case '÷':
          res = a / b;
          break;
        default:
          return;
      }

      final snapped = res.snapToDen(_snapDen);
      setState(() {
        _result =
            "Exact: ${res.toMixedString()}    →    1/$_snapDen: ${snapped.toMixedString()}";
      });
    } on FormatException catch (e) {
      setState(() => _result = e.message);
    } on ArgumentError catch (e) {
      setState(() => _result = e.message ?? 'Invalid input');
    } catch (e) {
      setState(() => _result = 'Error: $e');
    }
  }

  @override
  void dispose() {
    _aCtrl.dispose();
    _bCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trim Fraction Calculator')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Enter fractions like: 7 3/16, 3/4, 2, -1 5/8',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _aCtrl,
            decoration: const InputDecoration(
              labelText: 'First fraction',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _bCtrl,
            decoration: const InputDecoration(
              labelText: 'Second fraction',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Snap to 1/'),
              const SizedBox(width: 6),
              DropdownButton<int>(
                value: _snapDen,
                onChanged: (v) => setState(() => _snapDen = v!),
                items: _denoms
                    .map((d) => DropdownMenuItem(value: d, child: Text('$d')))
                    .toList(),
              ),
              const Text('"'),
            ],
          ),
          const SizedBox(height: 16),
          OpPad(onPressed: _onOp),
          const SizedBox(height: 24),
          SelectableText(
            _result.isEmpty ? 'Result will appear here' : _result,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
