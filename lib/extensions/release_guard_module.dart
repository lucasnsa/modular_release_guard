import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_release_guard/guard/release_guard.dart';

/// This extension can limit access to the ModuleRoute.
extension ModuleRouteReleaseControl on ModuleRoute {
  /// Return ModuleRoute with ReleaseGuard.
  /// without [guardedRoute] default value is [routerName] of ModuleRoute
  ModularRoute withReleaseControl({String? guardedRoute, String? redirectTo}) {
    final _guardedRoute = guardedRoute ?? Modular.to.path;
    final _guards = List<RouteGuard>.from(middlewares);
    if (kReleaseMode) {
      _guards.add(ReleaseGuard(_guardedRoute, redirectTo: redirectTo));
    }
    return copyWith(middlewares: _guards);
  }
}

/// This extension can limit access to the ChildRoute.
extension ChildRouteReleaseControl on ChildRoute {
  /// Return ChildRoute with ReleaseGuard.
  /// without [guardedRoute] default value is [routerName] of ChildRoute
  ModularRoute withReleaseControl({String? guardedRoute, String? redirectTo}) {
    final _guardedRoute = guardedRoute ?? Modular.to.path;
    final _guards = List<RouteGuard>.from(middlewares);
    if (kReleaseMode) {
      _guards.add(ReleaseGuard(_guardedRoute, redirectTo: redirectTo));
    }
    return copyWith(middlewares: _guards);
  }
}
