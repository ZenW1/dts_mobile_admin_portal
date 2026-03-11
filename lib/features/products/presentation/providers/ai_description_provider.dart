import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dts_admin_portal/core/services/gemini_service.dart';

/// Provider for GeminiService
final geminiServiceProvider = Provider<GeminiService>((ref) => GeminiService());

/// State notifier for AI description generation
class AIDescriptionNotifier extends StateNotifier<AsyncValue<String?>> {
  final GeminiService _service;

  AIDescriptionNotifier(this._service) : super(const AsyncValue.data(null));

  Future<void> generateDescription(String productName) async {
    if (productName.isEmpty) return;

    state = const AsyncValue.loading();
    try {
      final description =
          await _service.generateProductDescription(productName);
      state = AsyncValue.data(description);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  void reset() {
    state = const AsyncValue.data(null);
  }
}

/// Provider for AIDescriptionNotifier
final aiDescriptionNotifierProvider =
    StateNotifierProvider<AIDescriptionNotifier, AsyncValue<String?>>((ref) {
  final service = ref.watch(geminiServiceProvider);
  return AIDescriptionNotifier(service);
});
