import 'package:tulip_tea_order_booker/domain/entities/daily_collection.dart';

abstract class DailyCollectionRepository {
  Future<DailyCollection> submitCollection({
    required int orderBookerId,
    required int shopId,
    required double amount,
    String? collectedAt,
    String? remarks,
    int? visitId,
  });
  Future<List<DailyCollection>> getCollectionsByOrderBooker(int orderBookerId);
}
