import 'dart:io';

import 'package:base_router/route_paths_utils.dart';

const outputPath = 'lib/app_routes.dart';
void main() async {
  final paths = await readFile();
  generateRoutes(paths);
}

Future<List<String>> readFile() async {
  final filePath = RoutePathsUtils().routesPath; // Đường dẫn file
  final file = File(filePath);

  if (await file.exists()) {
    List<String> lines = await file.readAsLines();
    return lines;
  } else {
    print("❌ File không tồn tại: $filePath");
    return [];
  }
}

void generateRoutes(List<String> paths) {
  String classContent = '''
// GENERATED CODE - DO NOT MODIFY BY HAND
class AppRoutes {
  ${paths.map((e) => "static const String ${toCamelCase(e)} = '$e';").join("\n  ")}
}
''';

  Directory('lib').createSync(recursive: true);

  File(outputPath).writeAsStringSync(classContent);

  print("✅ Routes đã được generate thành công tại $outputPath!");
}

String toCamelCase(String path) {
  String cleanPath = path.startsWith("/") ? path.substring(1) : path;

  List<String> parts = cleanPath.split(RegExp(r'[/\-]'));

  return parts.asMap().entries.map((entry) {
    int index = entry.key;
    String word = entry.value;
    return index == 0
        ? word.toLowerCase()
        : word[0].toUpperCase() + word.substring(1);
  }).join();
}
