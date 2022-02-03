<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

Library that offers resources to control via Firebase Remote Config elements according to their build type.

## Features

* Controls the display of widgets and can even replace them.
* Protect routes from unauthorized access from [Flutter Modular](https://pub.dev/packages/flutter_modular).
* Use [Groveman](https://pub.dev/packages/groveman) to logs.
* Use [Firebase Remote Config](https://firebase.flutter.dev/docs/remote-config/overview) to get parameters.

## Getting started

This package depends on the Firebase Remote Config service. [See implementation details.](https://firebase.flutter.dev/docs/remote-config/overview)

This library uses parameters from Firebase Remote Config. `If the parameter is false only debug mode can access, otherwise it is available in release mode`.

Add to pubspec

```yaml
    groveman: any
    firebase_remote_config: any
    modular_release_guard: any
```

## Usage

### First step 

Includes initialize all library dependencies(Groveman and RemoteConfig).

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Groveman.plantTree(DebugTree(showColor: true));
  await Firebase.initializeApp();

  RemoteConfig remoteConfig = RemoteConfig.instance;

  await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: Duration(seconds: 10),
    minimumFetchInterval: Duration(hours: 1),
  ));

  // true para prod, false para apenas dev
  remoteConfig.setDefaults(<String, dynamic>{
    'clinics': false,
  });

  await remoteConfig.fetchAndActivate();
```

### Second

The following methods will be made available.

#### Widgets

Widget control can happen using the following methods:

```dart

    ...
    IconButton(
        onPressed: () {
                Modular.to.pushNamed('/clinics');
                    },
                icon: Icon(Icons.help))
              .withReleaseControl('clinics'),
        ],
      ),

```

The original widget can be replaced with another one.

```dart
    ...
    IconButton(
        onPressed: () {
                Modular.to.pushNamed('/clinics');
                    },
                icon: Icon(Icons.help))
              .withReleaseControl('clinics', replacement: Text('See later')),
        ],
      ),

```

#### Flutter Modular - Modules and Routes

Extensions are available to control modules and routes

```dart
 ModuleRoute(
          '/clinics',
          module: LocalClinicsModule(),
        ).withReleaseControl(),
```

Without any parameter the default parameter in Remote Config is initial route.


```dart
 ModuleRoute(
          '/clinics',
          module: LocalClinicsModule(),
        ).withReleaseControl('clinics_provided'),
```

Release control with parameter `clinics_provided` from Remote Config.

```dart
 ModuleRoute(
          '/clinics',
          module: LocalClinicsModule(),
        ).withReleaseControl('clinics_provided', redirectTo: '/comingsoon'),
```

Provides an alternative route.

## Additional information

Designed by [Kauê Martins](https://github.com/kmartins) and developed by [Lucas Náiade](https://github.com/lucasnsa), both from [Zambiee](https://www.zambiee.com.br).
