/// Logged-in user. For order booker, [id] is the order_booker_id.
class AuthUser {
  const AuthUser({
    required this.id,
    required this.name,
    required this.phone,
    this.email,
    this.zoneId,
    this.distributorId,
    required this.role,
  });

  final int id;
  final String name;
  final String phone;
  final String? email;
  final int? zoneId;
  final int? distributorId;
  final String role;

  int get orderBookerId => id;
}
