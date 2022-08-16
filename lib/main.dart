import 'package:flutter/material.dart';
import 'package:plumia/screens/home_screen.dart';
import 'package:provider/provider.dart';

import 'state/session.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Session>(
          create: (_) => Session(),
        ),
      ],
      child: MaterialApp(
        title: 'Plumia',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
