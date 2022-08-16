import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/session.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final session = Provider.of<Session>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plumia'),
      ),
      body: Center(
        child: Column(
          children: [
            if (!session.isAuthenticated)
              ElevatedButton(
                onPressed: session.login,
                child: const Text('Login'),
              ),
            if (session.isAuthenticated)
              ElevatedButton(
                onPressed: session.logout,
                child: const Text('Log out'),
              ),
            if (session.isAuthenticated)
              Text(
                'Logged in with address ${session.address} on network ${session.network?.name}',
              ),
          ],
        ),
      ),
    );
  }
}
