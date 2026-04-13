import 'package:flutter/material.dart';

/// A reusable widget used to display error messages in a clean UI.
///
/// This widget is typically used in MVVM (Stacked) views when
/// `hasError` is true in the ViewModel.
class ErrorView extends StatelessWidget {
  /// The error message to display to the user.
  final String message;

  /// Creates an [ErrorView] widget.
  const ErrorView({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        // Uses theme error color to keep UI consistent
        style: TextStyle(
          color: Theme.of(context).colorScheme.error,
          fontSize: 16,
        ),
      ),
    );
  }
}