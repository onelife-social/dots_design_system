import 'dart:io';

/// Recursively compiles all .svg files under the `assets/` directory into
/// `.svg.vec` files using `vector_graphics_compiler`.
///
/// Usage:
///   dart run tool/compile_svgs.dart
///
/// Optional flags:
///   --fail-fast   Stop on first compilation error (default: continue)
///
Future<void> main(List<String> args) async {
  final bool failFast = args.contains('--fail-fast');
  final Directory projectRoot = Directory.current;
  final Directory assetsDir = Directory('${projectRoot.path}/assets');

  if (!await assetsDir.exists()) {
    stderr.writeln('assets/ directory not found at: ${assetsDir.path}');
    exitCode = 2;
    return;
  }

  final List<File> svgFiles = await _findSvgFiles(assetsDir);
  if (svgFiles.isEmpty) {
    stdout.writeln('No .svg files found under ${assetsDir.path}');
    return;
  }

  stdout.writeln('Found ${svgFiles.length} .svg files. Compiling...');

  int successCount = 0;
  int failureCount = 0;

  for (final File svg in svgFiles) {
    final String inputPath = svg.path;
    final String outputPath = '$inputPath.vec';

    final ProcessResult result = await Process.run(
      'dart',
      [
        'run',
        'vector_graphics_compiler',
        '-i',
        inputPath,
        '-o',
        outputPath,
      ],
      runInShell: true,
    );

    if (result.exitCode == 0) {
      successCount++;
      stdout.writeln('✔ Compiled: $inputPath -> $outputPath');
    } else {
      failureCount++;
      stderr.writeln('✖ Failed: $inputPath');
      stderr.writeln(result.stderr);
      if (failFast) {
        exitCode = result.exitCode;
        return;
      }
    }
  }

  stdout.writeln('Done. Success: $successCount, Failed: $failureCount');
  if (failureCount > 0) {
    exitCode = 1;
  }
}

Future<List<File>> _findSvgFiles(Directory root) async {
  final List<File> results = <File>[];
  final Stream<FileSystemEntity> entities = root.list(recursive: true, followLinks: false);
  await for (final FileSystemEntity entity in entities) {
    if (entity is File && entity.path.toLowerCase().endsWith('.svg')) {
      results.add(entity);
    }
  }
  return results;
}


