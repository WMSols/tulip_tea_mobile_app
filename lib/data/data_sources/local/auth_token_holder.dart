/// In-memory holder for JWT. Set on login, cleared on logout/401.
class AuthTokenHolder {
  String? _token;

  String? get token => _token;

  void setToken(String? value) {
    _token = value;
  }

  void clear() {
    _token = null;
  }
}
