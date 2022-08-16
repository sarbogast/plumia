import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/session.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _login(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('WARNING'),
        content: const Text(
            'You will be taken to Auth0 to log in, and then you will need to click the "Continue with SIWE" button to Sign In With Ethereum.\n\nThen, after you Sign In With Ethereum, you can log in with your Ethereum wallet.\n\nOnce you have signed the message in your wallet, you might need to come back to Plumia on your own.'),
        actions: [
          ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Understood!'))
        ],
      ),
    );
    if (!mounted) return;
    await context.read<Session>().login();
  }

  @override
  Widget build(BuildContext context) {
    final session = Provider.of<Session>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        title: Image.asset(
          'assets/images/logo-transparent.png',
          height: 30,
        ),
        actions: [
          if (session.isLoggedIn)
            IconButton(
              icon: Icon(
                Icons.logout,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              onPressed: () {
                session.logout();
              },
            ),
        ],
      ),
      body: Center(
        child: !session.isLoggedIn
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo-image-transparent.png',
                    width: 300,
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'If you already have a profile in ProofOfHumanity',
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () => _login(context),
                    child: Text(
                      'Log in',
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 150,
                    backgroundImage: NetworkImage(
                      session.pohProfile!.photoUrl,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    session.pohProfile!.displayName,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    session.pohProfile!.address,
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.center,
                  )
                ],
              ),
      ),
    );
  }
}
