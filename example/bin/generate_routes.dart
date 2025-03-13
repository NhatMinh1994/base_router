import 'dart:io';

import 'package:base_router/base_router_app.dart';
import 'package:base_router/route_paths_utils.dart';
import 'package:example/test_router_have_bottom_tab_bar.dart';
import 'package:feature_1/router/first_feature_module_router.dart';
import 'package:feature_2/router/second_feature_module_router.dart';
import 'package:flutter/cupertino.dart';

class GenerateRoutes {
  void gen() {
    final file = File('example.txt');
    final buffer = StringBuffer();

    file.writeAsStringSync(buffer.toString());
    print('✅ route_paths.txt generated successfully!');
  }
}

void createFileInProject() {
  final file = File('example.txt');
  final buffer = StringBuffer();

  file.writeAsStringSync(buffer.toString());
  print('✅ route_paths.txt generated successfully!');
  // const routesPath = 'routes_path.txt';
  // final content = RoutePathsUtils.paths;
  // final file = File(routesPath); // Tạo file mới trong thư mục project
  // file.writeAsStringSync(content.join('\n'));
  //
  // debugPrint('✅ File created: ${file.absolute.path}');
}
