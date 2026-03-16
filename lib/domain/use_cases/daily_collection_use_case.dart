import 'package:tulip_tea_mobile_app/domain/entities/daily_collection.dart';
import 'package:tulip_tea_mobile_app/domain/repositories/daily_collection_repository.dart';

class DailyCollectionUseCase {
  DailyCollectionUseCase(this._repo);
  final DailyCollectionRepository _repo;

  Future<DailyCollection> submitCollection({
    required int orderBookerId,
    required int shopId,
    required double amount,
    String? collectedAt,
    String? remarks,
    int? visitId,
    int? orderId,
  }) => _repo.submitCollection(
    orderBookerId: orderBookerId,
    shopId: shopId,
    amount: amount,
    collectedAt: collectedAt,
    remarks: remarks,
    visitId: visitId,
    orderId: orderId,
  );

  Future<List<DailyCollection>> getCollectionsByOrderBooker(
    int orderBookerId,
  ) => _repo.getCollectionsByOrderBooker(orderBookerId);

  Future<DailyCollection> submitCollectionByDeliveryMan({
    required int deliveryManId,
    required int shopId,
    required double amount,
    String? collectedAt,
    String? remarks,
    int? orderId,
  }) => _repo.submitCollectionByDeliveryMan(
    deliveryManId: deliveryManId,
    shopId: shopId,
    amount: amount,
    collectedAt: collectedAt,
    remarks: remarks,
    orderId: orderId,
  );

  Future<List<DailyCollection>> getCollectionsByDeliveryMan(
    int deliveryManId,
  ) => _repo.getCollectionsByDeliveryMan(deliveryManId);
}
