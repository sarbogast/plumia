import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../enums/network.dart';
import '../models/poh_profile.dart';

const auth0Domain = String.fromEnvironment('AUTH0_DOMAIN');
const auth0ClientId = String.fromEnvironment('AUTH0_CLIENT_ID');
const auth0Scheme = String.fromEnvironment('AUTH0_SCHEME');

class Session extends ChangeNotifier {
  final _auth0 = Auth0(auth0Domain, auth0ClientId);
  final _dio = Dio();

  Credentials? _authenticatedCredentials;
  Network? _network;
  String? _address;
  PohProfile? _pohProfile;

  bool get isLoggedIn => _authenticatedCredentials != null;
  String? get address => _address;
  Network? get network => _network;
  PohProfile? get pohProfile => _pohProfile;

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
    if (_address != null) {
      final response = await _dio.get('https://api.poh.dev/profiles/$_address');
      final profile = PohProfile.fromJson(response.data);
      if (profile.registered) {
        _pohProfile = profile;
      }
    }
    notifyListeners();
  }

  Future<void> logout() async {
    await _auth0.webAuthentication().logout(scheme: auth0Scheme);
    _authenticatedCredentials = null;
    _network = null;
    _address = null;
    _pohProfile = null;
    notifyListeners();
  }
}
