import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/subscription_model.dart';
import '../models/ui_notifier_model.dart';

class EmailSubscriberProvider with ChangeNotifier {
  final String _endpoint = 'https://email-leads-api-latest.onrender.com/subscribe';

  final TextEditingController _emailController = TextEditingController();
  TextEditingController get emailController => _emailController;

  EmailNotifierUiModel? _emailNotifierUiModel;
  EmailNotifierUiModel? get emailNotifierUiModel => _emailNotifierUiModel;

  bool _loading = false;
  bool get loading => _loading;

  Future<void> subscribe(String email) async {
    
    _loading = true;
    _emailNotifierUiModel?.isLoading = true;
    _emailNotifierUiModel?.message = null;
    _emailNotifierUiModel?.resultState = UiResultState.loading;

    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse(_endpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );
      final decoded = jsonDecode(response.body);
      final result = SubscriptionResponse.fromJson(decoded);
      log("Message: ${result.message}, Email: ${result.email}");

      if (response.statusCode == 200 && result.message.toString().trim().toLowerCase() == 'subscription successful') {
        _emailNotifierUiModel?.message = "Subscribed successfully !";
        _emailNotifierUiModel?.resultState = UiResultState.completed;
      } else {
        _emailNotifierUiModel?.message = "Failed: ${response.body}";
        _emailNotifierUiModel?.resultState = UiResultState.error;
      }
    } catch (e) {
      _emailNotifierUiModel?.message = "Error: $e";
      _emailNotifierUiModel?.resultState = UiResultState.error;
    }

    _loading = false;
    _emailNotifierUiModel?.isLoading = false;
    notifyListeners();
  }
}
