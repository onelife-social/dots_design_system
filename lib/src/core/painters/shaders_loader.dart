import 'dart:ui';

import 'package:dots_design_system/src/core/core_lib.dart';
import 'package:dots_design_system/src/core/values/paths/shader_paths.dart';

class ShadersLoader {
  static final Map<String, FragmentProgram> _programs = {};

  static Future<void> preloadAll() async {
    try {
      _programs[ShaderType.blur.name] = await PaintersUtils.loadShader(ShaderPaths.blur);
    } catch (e) {
      print('Error loading shader ${ShaderPaths.blur}: $e');
      rethrow;
    }
  }

  static FragmentProgram getShader(ShaderType shaderType) {
    if (_programs.containsKey(shaderType.name)) {
      return _programs[shaderType.name]!;
    } else {
      throw Exception('Shader ${shaderType.name} not loaded. Call preloadAll() first.');
    }
  }
}
