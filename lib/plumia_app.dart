import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/home_screen.dart';
import 'state/session.dart';
import 'theme.dart';

class PlumiaApp extends StatelessWidget {
  const PlumiaApp({Key? key}) : super(key: key);

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
        theme: buildTheme(context),
        home: const HomeScreen(),
      ),
    );
  }
}
