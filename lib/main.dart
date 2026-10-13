import 'package:flutter/material.dart';

void main() {
  runApp(const FuelApp());
}

class FuelApp extends StatelessWidget {
  const FuelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fuel Consumption Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      ),
      home: const FuelCalculatorPage(),
    );
  }
}

class FuelCalculatorPage extends StatefulWidget {
  const FuelCalculatorPage({super.key});

  @override
  State<FuelCalculatorPage> createState() => _FuelCalculatorPageState();
}

class _FuelCalculatorPageState extends State<FuelCalculatorPage> {
  final TextEditingController _distanceController = TextEditingController();
  final TextEditingController _fuelController = TextEditingController();
  String _resultText = '';

  @override
  void dispose() {
    _distanceController.dispose();
    _fuelController.dispose();
    super.dispose();
  }

  double? _parsePositiveNumber(String value) {
    final number = double.tryParse(value.trim().replaceAll(',', '.'));
    if (number == null || !number.isFinite || number <= 0) {
      return null;
    }
    return number;
  }

  void _calculateConsumption() {
    final distance = _parsePositiveNumber(_distanceController.text);
    final fuel = _parsePositiveNumber(_fuelController.text);

    setState(() {
      if (distance == null || fuel == null) {
        _resultText = 'Please enter valid numbers greater than 0';
        return;
      }

      final consumption = fuel / distance * 100;
      _resultText =
          'Average Consumption:\n${consumption.toStringAsFixed(2)} L / 100 km';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fuel Consumption Calculator'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _distanceController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Distance traveled (km)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.add_road),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _fuelController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _calculateConsumption(),
              decoration: const InputDecoration(
                labelText: 'Fuel used (liters)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.local_gas_station),
              ),
            ),
            const SizedBox(height: 25),
            FilledButton(
              onPressed: _calculateConsumption,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text('Calculate'),
              ),
            ),
            const SizedBox(height: 30),
            if (_resultText.isNotEmpty)
              Text(
                _resultText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
