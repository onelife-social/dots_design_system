import 'dart:ui' as ui;

class PaintersUtils {
  static Future<ui.FragmentProgram> loadShader(String assetPath) async {
    try {
      return ui.FragmentProgram.fromAsset(assetPath);
    } catch (e) {
      print('Error loading shader from $assetPath: $e');
      rethrow;
    }
  }
}
