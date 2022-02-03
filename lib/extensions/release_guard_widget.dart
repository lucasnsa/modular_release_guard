import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

extension ReleaseWidget on Widget {
  /// Control whether the given [child] is [visible].
  ///
  /// The [child] and [replacement] arguments must not be null.
  ///
  /// The boolean arguments must not be null.
  ///
  /// The [maintainSemantics] and [maintainInteractivity] arguments can only be
  /// set if [maintainSize] is set.
  ///
  /// The [maintainSize] argument can only be set if [maintainAnimation] is set.
  ///
  /// The [maintainAnimation] argument can only be set if [maintainState] is
  /// set.
  Widget withReleaseControl(
    String route, {
    replacement = const SizedBox.shrink(),
    maintainState = false,
    maintainAnimation = false,
    maintainSize = false,
    maintainSemantics = false,
    maintainInteractivity = false,
  }) {
    final remoteConfig = FirebaseRemoteConfig.instance;
    final isVisible = kReleaseMode ? remoteConfig.getBool(route) : true;
    return Visibility(
      child: this,
      replacement: replacement,
      visible: isVisible,
      maintainState: maintainState,
      maintainAnimation: maintainAnimation,
      maintainSize: maintainSize,
      maintainSemantics: maintainSemantics,
      maintainInteractivity: maintainInteractivity,
    );
  }
}
