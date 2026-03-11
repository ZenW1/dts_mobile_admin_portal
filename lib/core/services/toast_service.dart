import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class ToastService {
  static void success({
    required String message,
    String? title,
    Duration? duration,
  }) {
    toastification.show(
      title: Text(title ?? 'Success'),
      description: Text(message),
      type: ToastificationType.success,
      style: ToastificationStyle.flatColored,
      autoCloseDuration: duration ?? const Duration(seconds: 4),
      alignment: Alignment.topRight,
      animationDuration: const Duration(milliseconds: 300),
      borderRadius: BorderRadius.circular(12),
      // showProgressBar: true,
      closeButtonShowType: CloseButtonShowType.always,
    );
  }

  static void error({
    required String message,
    String? title,
    Duration? duration,
  }) {
    toastification.show(
      title: Text(title ?? 'Error'),
      description: Text(message),
      type: ToastificationType.error,
      style: ToastificationStyle.flatColored,
      autoCloseDuration: duration ?? const Duration(seconds: 5),
      alignment: Alignment.topRight,
      animationDuration: const Duration(milliseconds: 300),
      borderRadius: BorderRadius.circular(12),
      // showProgressBar: true,
      closeButtonShowType: CloseButtonShowType.always,
    );
  }

  static void info({
    required String message,
    String? title,
    Duration? duration,
  }) {
    toastification.show(
      title: Text(title ?? 'Info'),
      description: Text(message),
      type: ToastificationType.info,
      style: ToastificationStyle.flatColored,
      autoCloseDuration: duration ?? const Duration(seconds: 4),
      alignment: Alignment.topRight,
      animationDuration: const Duration(milliseconds: 300),
      borderRadius: BorderRadius.circular(12),
      showProgressBar: true,
      closeButtonShowType: CloseButtonShowType.always,
    );
  }

  static void warning({
    required String message,
    String? title,
    Duration? duration,
  }) {
    toastification.show(
      title: Text(title ?? 'Warning'),
      description: Text(message),
      type: ToastificationType.warning,
      style: ToastificationStyle.flatColored,
      autoCloseDuration: duration ?? const Duration(seconds: 4),
      alignment: Alignment.topRight,
      animationDuration: const Duration(milliseconds: 300),
      borderRadius: BorderRadius.circular(12),
      // showProgressBar: true,
      closeButtonShowType: CloseButtonShowType.always,
    );
  }
}
