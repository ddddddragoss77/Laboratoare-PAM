import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/fitness_data_model.dart';

class FitnessRepository {
  final String assetPath;

  FitnessRepository({this.assetPath = 'assets/data/lab_v3.json'});

  /// Loads fitness data asynchronously from local JSON asset.
  Future<FitnessDataModel> loadFitnessData({bool simulateError = false}) async {
    // Simulate network latency for state management testing (Loading state)
    await Future.delayed(const Duration(milliseconds: 900));

    if (simulateError) {
      throw Exception('Eroare la încărcarea datelor! Conexiunea a eșuat.');
    }

    try {
      final String jsonString = await rootBundle.loadString(assetPath);
      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      return FitnessDataModel.fromJson(jsonMap);
    } catch (e) {
      throw Exception('Format de date invalid sau fișierul JSON lipsește: $e');
    }
  }
}
