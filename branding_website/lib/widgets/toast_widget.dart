import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../models/ui_notifier_model.dart';

void showEmailNotifierToast(BuildContext context, EmailNotifierUiModel? model) {
  if (model == null) {
    debugPrint('[Toast] EmailNotifierUiModel is null, skipping toast.');
    return;
  }

  if (model.isLoading == true) {
    debugPrint('[Toast] Still loading, toast will not be shown.');
    return;
  }

  final overlay = Overlay.of(context);

  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: MediaQuery.of(context).viewPadding.top + 20,
      left: 20,
      right: 20,
      child: Material(
        color: Colors.transparent,
        child: _ToastContent(model: model),
      ),
    ),
  );

  overlay.insert(overlayEntry);

  SchedulerBinding.instance.addPostFrameCallback((_) {
    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  });
}

class _ToastContent extends StatelessWidget {
  final EmailNotifierUiModel model;

  const _ToastContent({required this.model});

  @override
  Widget build(BuildContext context) {
    final isSuccess = model.resultState == UiResultState.completed;
    final bgColor = isSuccess ? Colors.green : Colors.amber[700];
    final icon = isSuccess ? Icons.check_circle : Icons.warning_amber_rounded;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 250),
      opacity: 1,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                model.message ?? '',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}