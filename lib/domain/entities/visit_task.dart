/// Today's visit task (shop scheduled for visit)
class VisitTask {
  const VisitTask({
    required this.id,
    required this.shopId,
    this.shopName,
    this.routeName,
  });

  final int id;
  final int shopId;
  final String? shopName;
  final String? routeName;
}
