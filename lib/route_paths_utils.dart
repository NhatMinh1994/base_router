import 'dart:io';

class RoutePathsUtils {
  static List<String> paths = [];
  final routesPath = '/tmp/routes_path.txt';
  void createFileInProject(String content) {
    final file = File(routesPath); // Tạo file mới trong thư mục project
    file.writeAsStringSync(content);

    print('✅ File created: ${file.absolute.path}');
  }

  Future<List<String>> readListFromFile() async {
    final file = File('$routesPath.txt');

    if (await file.exists()) {
      return await file.readAsLines(); // Đọc từng dòng thành List<String>
    }
    return [];
  }
}
