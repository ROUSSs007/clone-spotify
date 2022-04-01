import 'dart:io';

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spotify_ui/data/data.dart';
import 'package:flutter_spotify_ui/models/current_track_model.dart';
import 'package:flutter_spotify_ui/screens/playlist_screen.dart';
import 'package:flutter_spotify_ui/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb && (Platform.isMacOS || Platform.isLinux || Platform.isWindows)) {
    await DesktopWindow.setMinWindowSize(const Size(600, 800));
  }
  runApp(
    ChangeNotifierProvider(
      create: (context) => CurrentTrackModel(),
      child: MyApp(),
    ),
  );

  doWhenWindowReady(() {
    const initialSize = Size(600, 800);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Spotify UI',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
        scaffoldBackgroundColor: const Color(0xFF121212),
        backgroundColor: const Color(0xFF121212),
        primaryColor: Colors.black,
        accentColor: const Color(0xFF1DB954),
        iconTheme: const IconThemeData().copyWith(color: Colors.white),
        fontFamily: 'Montserrat',
        textTheme: TextTheme(
          headline2: const TextStyle(
            color: Colors.white,
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
          ),
          headline4: TextStyle(
            fontSize: 12.0,
            color: Colors.grey[300],
            fontWeight: FontWeight.w500,
            letterSpacing: 2.0,
          ),
          bodyText1: TextStyle(
            color: Colors.grey[300],
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.0,
          ),
          bodyText2: TextStyle(
            color: Colors.grey[300],
            fontSize: 10.0,
            height: 0.0,
            letterSpacing: 1.0,
          ),
        ),
      ),
      home: Shell(),
    );
  }
}

class Shell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          WindowTitleBarBox(
            child: Row(
              children: [Expanded(child: MoveWindow()), WindowButtons()],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                if (MediaQuery.of(context).size.width > 800) SideMenu(),
                const Expanded(
                  child: PlaylistScreen(
                    playlist: lofihiphopPlaylist,
                  ),
                ),
              ],
            ),
          ),
          CurrentTrack(),
        ],
      ),
    );
  }
}

var buttonColors = WindowButtonColors(
  iconNormal: Colors.white,
);

class WindowButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        MaximizeWindowButton(colors: buttonColors),
        CloseWindowButton(colors: buttonColors),
      ],
    );
  }
}
