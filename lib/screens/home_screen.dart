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
        actions: [
          if (session.isLoggedIn)
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                session.logout();
              },
            ),
        ],
      ),
      body: Center(
        child: !session.isLoggedIn
            ? Center(
                child: ElevatedButton(
                  onPressed: session.login,
                  child: const Text('Login'),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.network(
                    session.pohProfile!.photoUrl,
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    session.pohProfile!.displayName,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    session.pohProfile!.address,
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  )
                ],
              ),
      ),
    );
  }
}
