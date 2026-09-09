import 'package:flutter/services.dart';

/// Platform channel bridge to interact with native on-device dictionaries
/// (e.g. iOS UIReferenceLibraryViewController and Android ACTION_DEFINE).
class DeviceDictionaryService {
  static const MethodChannel _channel = MethodChannel('com.bomb.study/dictionary');

  /// Requests the operating system to open its downloaded/native dictionary for [word].
  /// On iOS, this presents the native UIReferenceLibraryViewController.
  /// On Android, this fires an ACTION_DEFINE intent to installed dictionary apps.
  static Future<bool> openDeviceDictionary(String word) async {
    final cleanWord = word.trim().replaceAll(RegExp(r'[^a-zA-Z]'), '');
    if (cleanWord.isEmpty) return false;

    try {
      final bool? result = await _channel.invokeMethod<bool>('openDeviceDictionary', {
        'word': cleanWord,
      });
      return result ?? false;
    } catch (_) {
      return false;
    }
  }
}
