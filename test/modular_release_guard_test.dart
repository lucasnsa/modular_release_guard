import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_remote_config_platform_interface/firebase_remote_config_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:modular_release_guard/modular_release_guard.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'package:mockito/mockito.dart';

import 'mock.dart';

MockFirebaseRemoteConfig mockRemoteConfigPlatform = MockFirebaseRemoteConfig();

void main() {
  setupFirebaseRemoteConfigMocks();

  late FirebaseRemoteConfig remoteConfig;
  late DateTime mockLastFetchTime;
  late RemoteConfigFetchStatus mockLastFetchStatus;
  late RemoteConfigSettings mockRemoteConfigSettings;
  late Map<String, RemoteConfigValue> mockParameters;
  // ignore: unused_local_variable
  late Map<String, dynamic> mockDefaultParameters;
  late RemoteConfigValue mockRemoteConfigValue;

  group('$FirebaseRemoteConfig', () {
    FirebaseRemoteConfigPlatform.instance = mockRemoteConfigPlatform;

    setUpAll(() async {
      await Firebase.initializeApp();
      remoteConfig = FirebaseRemoteConfig.instance;

      mockLastFetchTime = DateTime(2020);
      mockLastFetchStatus = RemoteConfigFetchStatus.noFetchYet;
      mockRemoteConfigSettings = RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(hours: 1),
      );
      mockParameters = <String, RemoteConfigValue>{};
      mockDefaultParameters = <String, dynamic>{};
      mockRemoteConfigValue = RemoteConfigValue(
        <int>[],
        ValueSource.valueStatic,
      );

      when(mockRemoteConfigPlatform.instanceFor(
              app: anyNamed('app'),
              pluginConstants: anyNamed('pluginConstants')))
          .thenAnswer((_) => mockRemoteConfigPlatform);

      when(mockRemoteConfigPlatform.delegateFor(
        app: anyNamed('app'),
      )).thenAnswer((_) => mockRemoteConfigPlatform);

      when(mockRemoteConfigPlatform.setInitialValues(
              remoteConfigValues: anyNamed('remoteConfigValues')))
          .thenAnswer((_) => mockRemoteConfigPlatform);

      when(mockRemoteConfigPlatform.lastFetchTime)
          .thenReturn(mockLastFetchTime);

      when(mockRemoteConfigPlatform.lastFetchStatus)
          .thenReturn(mockLastFetchStatus);

      when(mockRemoteConfigPlatform.settings)
          .thenReturn(mockRemoteConfigSettings);

      when(mockRemoteConfigPlatform.setConfigSettings(any))
          .thenAnswer((_) => Future.value());

      when(mockRemoteConfigPlatform.activate())
          .thenAnswer((_) => Future.value(true));

      when(mockRemoteConfigPlatform.ensureInitialized())
          .thenAnswer((_) => Future.value());

      when(mockRemoteConfigPlatform.fetch()).thenAnswer((_) => Future.value());

      when(mockRemoteConfigPlatform.fetchAndActivate())
          .thenAnswer((_) => Future.value(true));

      when(mockRemoteConfigPlatform.getAll()).thenReturn(mockParameters);

      when(mockRemoteConfigPlatform.getBool('foo')).thenReturn(true);

      when(mockRemoteConfigPlatform.getInt('foo')).thenReturn(8);

      when(mockRemoteConfigPlatform.getDouble('foo')).thenReturn(8.8);

      when(mockRemoteConfigPlatform.getString('foo')).thenReturn('bar');

      when(mockRemoteConfigPlatform.getValue('foo'))
          .thenReturn(mockRemoteConfigValue);

      when(mockRemoteConfigPlatform.setDefaults(any))
          .thenAnswer((_) => Future.value());
    });

    testWidgets('Widget is visible', (WidgetTester tester) async {
      await tester.pumpWidget(
          MaterialApp(home: const Text('Teste').withReleaseControl('foo')));
      final visibityWidget = tester.widget<Visibility>(find.byType(Visibility));
      final fromServer = remoteConfig.getBool('foo');
      final isVisible = visibityWidget.visible;

      expect(fromServer, isVisible);
    });
  });
}

class MockFirebaseRemoteConfig extends Mock
    with
        // ignore: prefer_mixin
        MockPlatformInterfaceMixin
    implements
        TestFirebaseRemoteConfigPlatform {
  MockFirebaseRemoteConfig() {
    TestFirebaseRemoteConfigPlatform();
  }

  @override
  FirebaseRemoteConfigPlatform delegateFor({FirebaseApp? app}) {
    return super.noSuchMethod(
      Invocation.method(#delegateFor, [], {#app: app}),
      returnValue: TestFirebaseRemoteConfigPlatform(),
      returnValueForMissingStub: TestFirebaseRemoteConfigPlatform(),
    );
  }

  @override
  FirebaseRemoteConfigPlatform setInitialValues({Map? remoteConfigValues}) {
    return super.noSuchMethod(
      Invocation.method(
          #setInitialValues, [], {#remoteConfigValues: remoteConfigValues}),
      returnValue: TestFirebaseRemoteConfigPlatform(),
      returnValueForMissingStub: TestFirebaseRemoteConfigPlatform(),
    );
  }

  @override
  Future<bool> activate() {
    return super.noSuchMethod(Invocation.method(#activate, []),
        returnValue: Future<bool>.value(true),
        returnValueForMissingStub: Future<bool>.value(true));
  }

  @override
  Future<void> ensureInitialized() {
    return super.noSuchMethod(Invocation.method(#ensureInitialized, []),
        returnValue: Future<void>.value(),
        returnValueForMissingStub: Future<void>.value());
  }

  @override
  Future<void> fetch() {
    return super.noSuchMethod(Invocation.method(#fetch, []),
        returnValue: Future<void>.value(),
        returnValueForMissingStub: Future<void>.value());
  }

  @override
  Future<bool> fetchAndActivate() {
    return super.noSuchMethod(Invocation.method(#fetchAndActivate, []),
        returnValue: Future<bool>.value(true),
        returnValueForMissingStub: Future<bool>.value(true));
  }

  @override
  Future<void> setConfigSettings(RemoteConfigSettings? remoteConfigSettings) {
    return super.noSuchMethod(
      Invocation.method(#setConfigSettings, [remoteConfigSettings]),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value(),
    );
  }

  @override
  Future<void> setDefaults(Map<String, dynamic>? defaultParameters) {
    return super.noSuchMethod(
      Invocation.method(#setDefaults, [defaultParameters]),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value(),
    );
  }

  @override
  Map<String, RemoteConfigValue> getAll() {
    return super.noSuchMethod(
      Invocation.method(#getAll, []),
      returnValue: <String, RemoteConfigValue>{},
      returnValueForMissingStub: <String, RemoteConfigValue>{},
    );
  }

  @override
  bool getBool(String key) {
    return super.noSuchMethod(
      Invocation.method(#getBool, [key]),
      returnValue: true,
      returnValueForMissingStub: true,
    );
  }

  @override
  int getInt(String key) {
    return super.noSuchMethod(
      Invocation.method(#getInt, [key]),
      returnValue: 8,
      returnValueForMissingStub: 8,
    );
  }

  @override
  String getString(String key) {
    return super.noSuchMethod(
      Invocation.method(#getString, [key]),
      returnValue: 'foo',
      returnValueForMissingStub: 'foo',
    );
  }

  @override
  double getDouble(String key) {
    return super.noSuchMethod(
      Invocation.method(#getDouble, [key]),
      returnValue: 8.8,
      returnValueForMissingStub: 8.8,
    );
  }

  @override
  RemoteConfigValue getValue(String key) {
    return super.noSuchMethod(
      Invocation.method(#getValue, [key]),
      returnValue: RemoteConfigValue(
        <int>[],
        ValueSource.valueStatic,
      ),
      returnValueForMissingStub: RemoteConfigValue(
        <int>[],
        ValueSource.valueStatic,
      ),
    );
  }

  @override
  RemoteConfigFetchStatus get lastFetchStatus {
    return super.noSuchMethod(
      Invocation.getter(#lastFetchStatus),
      returnValue: RemoteConfigFetchStatus.success,
      returnValueForMissingStub: RemoteConfigFetchStatus.success,
    );
  }

  @override
  DateTime get lastFetchTime {
    return super.noSuchMethod(
      Invocation.getter(#lastFetchTime),
      returnValue: DateTime(2020),
      returnValueForMissingStub: DateTime(2020),
    );
  }

  @override
  RemoteConfigSettings get settings {
    return super.noSuchMethod(
      Invocation.getter(#settings),
      returnValue: RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(hours: 1),
      ),
      returnValueForMissingStub: RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(hours: 1),
      ),
    );
  }
}

class TestFirebaseRemoteConfigPlatform extends FirebaseRemoteConfigPlatform {
  TestFirebaseRemoteConfigPlatform() : super();

  void instanceFor({
    FirebaseApp? app,
    Map<dynamic, dynamic>? pluginConstants,
  }) {}

  @override
  FirebaseRemoteConfigPlatform delegateFor({FirebaseApp? app}) {
    return this;
  }

  @override
  FirebaseRemoteConfigPlatform setInitialValues(
      {Map<dynamic, dynamic>? remoteConfigValues}) {
    return this;
  }
}
