import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _auth0 = Auth0(
    const String.fromEnvironment('AUTH0_DOMAIN'),
    const String.fromEnvironment('AUTH0_CLIENT_ID'),
  );
  UserProfile? _loggedInUser;
  String? _chainId;
  String? _address;

  Future<void> _login() async {
    final credentials = await _auth0
        .webAuthentication()
        .login(scheme: const String.fromEnvironment('AUTH0_SCHEME'));
    setState(() {
      _loggedInUser = credentials.user;
      final decodedSubject = Uri.decodeFull(_loggedInUser!.sub);
      final elements = decodedSubject.split(':');
      if (elements[0] == 'oauth2|siwe|eip155') {
        _chainId = elements[1];
        _address = elements[2];
      }
    });
  }

  Future<void> _logout() async {
    await _auth0
        .webAuthentication()
        .logout(scheme: const String.fromEnvironment('AUTH0_SCHEME'));
    setState(() {
      _loggedInUser = null;
      _chainId = null;
      _address = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            if (_loggedInUser == null)
              ElevatedButton(
                onPressed: _login,
                child: const Text('Login'),
              ),
            if (_loggedInUser != null)
              ElevatedButton(
                onPressed: _logout,
                child: const Text('Log out'),
              ),
            if (_loggedInUser != null)
              Text(
                'Logged in as ${Uri.decodeFull(_loggedInUser!.sub)}',
              ),
            if (_chainId != null) Text('Chain ID: $_chainId'),
            if (_address != null) Text('Address: $_address'),
          ],
        ),
      ),
    );
  }
}
