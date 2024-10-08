import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mass_pro/data_run/screens/form_ui_elements/get_error_widget.dart';

/// Generic AsyncValueWidget to work with values of type T
class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget({super.key, required this.value, required this.data});

  // input async value
  final AsyncValue<T> value;

  // output builder function
  final Widget Function(T) data;

  @override
  Widget build(BuildContext context) {
    return switch (value) {
      AsyncValue(error: final error?, stackTrace: final stackTrace) =>
        getErrorWidget(error, stackTrace),
      AsyncValue(valueOrNull: final valueOrNull?) => data.call(valueOrNull),
      _ => const CircularProgressIndicator(),
    };
  }
}
