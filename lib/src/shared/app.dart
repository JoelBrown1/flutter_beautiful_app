import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beautiful_app/src/shared/playback/bloc/playback_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import '../shared/playback/bloc/';
import '../shared/providers/theme.dart';
import 'router.dart';
import '../shared/views/play_pause_listener.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final settings = ValueNotifier(ThemeSettings(
    sourceColor: Colors.pink,
    themeMode: ThemeMode.system,
  ));

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PlaybackBloc>(
      create: (context) => PlaybackBloc(),
      child: DynamicColorBuilder(
        builder: (lightDynamic, darkDynamic) => ThemeProvider(
          settings: settings,
          lightDynamic: lightDynamic,
          darkDynamic: darkDynamic,
          child: NotificationListener<ThemeSettingChange>(
            onNotification: (notification) {
              settings.value = notification.settings;
              return true;
            },
            child: ValueListenableBuilder<ThemeSettings>(
              valueListenable: settings,
              builder: (context, value, _) {
                return MaterialApp.router(
                  debugShowCheckedModeBanner: false,
                  title: 'flutter demo',
                  routeInformationParser: appRouter.routeInformationParser,
                  routeInformationProvider: appRouter.routeInformationProvider,
                  routerDelegate: appRouter.routerDelegate,
                  builder: (context, child) {
                    return PlayPauseListener(child: child!);
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
