import 'dart:async';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter_modular/flutter_modular.dart';
import 'package:groveman/groveman.dart';

class ReleaseGuard extends RouteGuard {
  final isDev = foundation.kDebugMode;
  final remoteConfig = Modular.get<RemoteConfig>();
  final String? releaseGuardedRoute;

  ReleaseGuard(this.releaseGuardedRoute, {redirectTo})
      : super(redirectTo: redirectTo);

  @override
  Future<bool> canActivate(String path, ModularRoute route) {
    final modulePath = path.replaceAll('/', '');
    final isGrant = remoteConfig.getBool(modulePath);
    if (isGrant) {
      Groveman.debug('ReleaseGuard grant acess;');
      return Future.value(true);
    } else {
      Groveman.debug('ReleaseGuard block acess;');
      return Future.value(false);
    }
  }
}
