import 'dart:io';

import 'package:compta_repo/client_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:window_size/window_size.dart';

import 'homepage_view.dart';
import 'clients_view.dart';

void main() {
  setupWindow();
  runApp(const MyApp());
}

const double windowWidth = 400;
const double windowHeight = 800;

void setupWindow() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    WidgetsFlutterBinding.ensureInitialized();
    setWindowTitle('Compta');
    setWindowMinSize(const Size(windowWidth, windowHeight));
    setWindowMaxSize(const Size(windowWidth, windowHeight));
    getCurrentScreen().then((screen) {
      setWindowFrame(Rect.fromCenter(
        center: screen!.frame.center,
        width: windowWidth,
        height: windowHeight,
      ));
    });
  }

  print("window is setup");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const PanelHomepage(),
        PanelClients.routeName: (context) => const PanelClients(),
        PanelClientEdit.routeAdd: (context) =>
            const PanelClientEdit(state: ClientViewState.add),
        PanelClientEdit.routeEdit: (context) =>
            const PanelClientEdit(state: ClientViewState.edit),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark),
      //home: const HomepagePanel(),
    );
  }
}
