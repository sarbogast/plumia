import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter/foundation.dart';

import '../enums/network.dart';

const auth0Domain = String.fromEnvironment('AUTH0_DOMAIN');
const auth0ClientId = String.fromEnvironment('AUTH0_CLIENT_ID');
const auth0Scheme = String.fromEnvironment('AUTH0_SCHEME');

class Session extends ChangeNotifier {
  final _auth0 = Auth0(auth0Domain, auth0ClientId);

  Credentials? _authenticatedCredentials;
  Network? _network;
  String? _address;

  bool get isAuthenticated => _authenticatedCredentials != null;
  String? get address => _address;
  Network? get network => _network;

  Future<void> login() async {
    _authenticatedCredentials = await _auth0.webAuthentication().login(
          scheme: auth0Scheme,
        );
    final decodedSubject = Uri.decodeFull(_authenticatedCredentials!.user.sub);
    final oAuthElements = decodedSubject.split('|');
    final identifier = oAuthElements[oAuthElements.length - 1];
    final identifierElements = identifier.split(':');
    if (identifierElements[0] == 'eip155') {
      final chainId = identifierElements[1];
      final chainIdInt = int.tryParse(chainId);
      if (chainIdInt == null) {
        _network = null;
      } else {
        _network = Network.fromChainId(chainIdInt);
      }
      _address = identifierElements[2];
    }
    notifyListeners();
  }

  Future<void> logout() async {
    await _auth0.webAuthentication().logout(scheme: auth0Scheme);
    _authenticatedCredentials = null;
    _network = null;
    _address = null;
    notifyListeners();
  }
}
