import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:learniverse/core/core.dart';
import 'package:learniverse/firebase_options.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  DI.init();
  runApp(MultiProvider(
      child: const MyApp(),
  providers: initProviders,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Learniverse',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      routerConfig: getRouter(),
    );
  }
}
