import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import 'navigator_service_interface.dart';

final getIt = GetIt.instance;

class GoRouterNavigationService implements NavigationService {
  final GoRouter _router;

  GoRouterNavigationService(this._router);

  String? _getCurrentLocation(BuildContext? context) {
    if (context == null) return null;
    return GoRouterState.of(context).uri.toString();
  }

  @override
  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return _router.push(routeName, extra: arguments);
  }

  @override
  Future<dynamic> replaceTo(String routeName, {dynamic arguments}) {
    _router.go(routeName, extra: arguments);
    return Future.value();
  }

  @override
  Future<dynamic> removeUntil(String routeName, {dynamic arguments}) {
    _router.go(routeName, extra: arguments);
    return Future.value();
  }

  @override
  void popUntil(String routeName, {dynamic arguments, bool safety = true}) {
    final context = _router.routerDelegate.navigatorKey.currentContext;
    if (context == null) return;

    String? currentLocation = _getCurrentLocation(context);
    while (_router.canPop() && currentLocation != routeName) {
      _router.pop();
      currentLocation = _getCurrentLocation(context);
    }

    if (currentLocation != routeName && !safety) {
      _router.go(routeName, extra: arguments);
    }
  }

  @override
  Future<dynamic> popAndNavigateTo(String routeName, {dynamic arguments}) {
    if (_router.canPop()) {
      _router.pop();
    }
    return _router.push(routeName, extra: arguments);
  }

  @override
  Future<dynamic>? pushNamedAndRemoveUntilSafety(
    String newRouteName,
    String predicateRouteName, {
    Object? arguments,
  }) {
    final context = _router.routerDelegate.navigatorKey.currentContext;
    if (context == null) return null;

    String? currentLocation = _getCurrentLocation(context);
    if (currentLocation != null &&
        currentLocation.contains(predicateRouteName)) {
      _router.go(predicateRouteName);
      return _router.push(newRouteName, extra: arguments);
    } else {
      return _router.push(newRouteName, extra: arguments);
    }
  }

  @override
  void goBack<T extends Object?>([T? result]) {
    if (_router.canPop()) {
      _router.pop(result);
    }
  }
}
