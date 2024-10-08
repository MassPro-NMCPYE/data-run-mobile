import 'dart:developer' as developer;

import 'package:mass_pro/commons/logging/mp_main.dart';
import 'package:mass_pro/commons/logging/mp_utils.dart';

///VoidCallback from logs
typedef LogWriterCallback = void Function(String text, {bool isError});

/// default logger from GetX
void defaultLogWriterCallback(String value, {bool isError = false}) {
  if (isError || Mp.isLogEnable) {
    developer.log(value, name: '');
  }
}

void logError(
        {String info = '',
        Function logFunction = MpUtils.printFunction,
        Type? runtimeType}) =>
    // ignore: unnecessary_this
    logFunction('Error: ${runtimeType ?? ''}', '', info, isError: true);

void logInfo(
        {String info = '',
        Function printFunction = MpUtils.printFunction,
        Type? runtimeType}) =>
    // ignore: unnecessary_this
    printFunction('Info: ${runtimeType ?? ''}', '', info);
