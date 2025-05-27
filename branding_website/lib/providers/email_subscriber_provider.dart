import 'dart:convert';
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

  Future<EmailNotifierUiModel> subscribe(String email) async {
    _loading = true;
    _emailNotifierUiModel = EmailNotifierUiModel(
      isLoading: true,
      message: null,
      resultState: UiResultState.loading,
    );
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse(_endpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      final decoded = jsonDecode(response.body);
      final result = SubscriptionResponse.fromJson(decoded);

      if (response.statusCode == 200 &&
          result.message.toString().trim().toLowerCase() == 'subscription successful') {
        _emailNotifierUiModel = EmailNotifierUiModel(
          message: "Subscribed successfully!",
          isLoading: false,
          resultState: UiResultState.completed,
        );
      } else {
        _emailNotifierUiModel = EmailNotifierUiModel(
          message: "Failed: ${result.message}",
          isLoading: false,
          resultState: UiResultState.error,
        );
      }
    } catch (e) {
      _emailNotifierUiModel = EmailNotifierUiModel(
        message: "Error: $e",
        isLoading: false,
        resultState: UiResultState.error,
      );
    }

    _loading = false;
    notifyListeners();

    return _emailNotifierUiModel!;
  }
}
