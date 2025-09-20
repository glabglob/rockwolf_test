import 'dart:async';
import 'dart:math';

class UploadService {
  Future<void> upload(String path) async {
    await Future.delayed(const Duration(seconds: 2));

    if (Random().nextInt(100) < 30) {
      throw Exception("Network error");
    }
  }
}
