import 'package:base_router/route_paths_utils.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import 'module_router_interface.dart';

final service = GetIt.instance;

class BaseRouterApp extends StatelessWidget {
  final List<IModuleRouter> _modules;
  final List<RouteBase> _routes = [];

  BaseRouterApp({required List<IModuleRouter> modules, super.key})
      : _modules = modules {
    for (var module in _modules) {
      module.init(service);
      if (hasDuplicatePaths(module)) {
        throw Exception('Duplicate path found');
      } else {
        _routes.addAll(
          module.router(),
        );
      }
    }
    String content = _extractPaths(_routes).join('\n');
    _writeFile(content);
  }
  bool hasDuplicatePaths(IModuleRouter module) {
    final pathsOfModule = _extractPaths(module.router());
    final totalOfPaths = _extractPaths(_routes);
    for (var path in pathsOfModule) {
      if (totalOfPaths.contains(path)) {
        debugPrint('Duplicate path found: $path');
        return true;
      }
    }
    return false;
  }

  void _writeFile(String content) {
    RoutePathsUtils().createFileInProject(content);
  }

  List<String> _extractPaths(List<RouteBase> routes, {String parentPath = ''}) {
    final paths = <String>[];

    for (var route in routes) {
      if (route is GoRoute) {
        final fullPath = '$parentPath/${route.path}'.replaceAll('//', '/');
        paths.add(fullPath);

        if (route.routes.isNotEmpty) {
          paths.addAll(_extractPaths(route.routes, parentPath: fullPath));
        }
      } else if (route is ShellRoute) {
        paths.addAll(_extractPaths(route.routes, parentPath: parentPath));
      } else if (route is StatefulShellRoute) {
        for (var branch in route.branches) {
          paths.addAll(_extractPaths(branch.routes, parentPath: parentPath));
        }
      } else {
        debugPrint('Type of route not supported: ${route.runtimeType}');
      }
    }
    return paths;
  }

  @override
  Widget build(final BuildContext context) {
    return MaterialApp.router(
      routerConfig: GoRouter(
        initialLocation: '/firstScreen',
        routes: _routes,
      ),
    );
  }
}

class ModuleWrapper extends StatelessWidget {
  final Widget child;
  const ModuleWrapper({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
    );
  }
}
