import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

/// Interface defining the contract for module routing configuration.
///
/// This abstract class provides a blueprint for implementing routing
/// functionality in different modules of an application. It ensures that
/// each module router properly initializes its dependencies and provides
/// its routing configuration.
///
/// Implementers must provide concrete implementations for dependency
/// initialization and route definitions.
abstract class IModuleRouter {
  /// Initializes the module with required services and dependencies.
  ///
  /// This method should be called to set up the module's dependencies
  /// using the provided [GetIt] service locator instance.
  ///
  /// [service] The GetIt service locator instance used to register
  /// or access dependencies.
  void init(final GetIt service);

  /// Defines the routes for this module.
  ///
  /// Returns a list of [RouteBase] objects that define the navigation
  /// structure for this module. These routes will be used by the
  /// [GoRouter] to handle navigation.
  ///
  /// Returns a [List<RouteBase>] containing all route configurations
  /// for the module.
  List<RouteBase> router();

  /// A [GlobalKey] for the top-level [Navigator] in this module.
  ///
  /// This key is used to access the [NavigatorState] of the top-level
  /// [Navigator] for this module. It is used to inject the navigator
  /// state into the [GoRouter] instance so that it can properly handle
  /// navigation events.
}
