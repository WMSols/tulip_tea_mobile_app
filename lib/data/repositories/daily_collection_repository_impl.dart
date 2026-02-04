import 'package:tulip_tea_order_booker/core/network/api_exceptions.dart';
import 'package:tulip_tea_order_booker/domain/entities/daily_collection.dart';
import 'package:tulip_tea_order_booker/domain/repositories/daily_collection_repository.dart';
import 'package:tulip_tea_order_booker/data/data_sources/remote/daily_collections_api.dart';
import 'package:tulip_tea_order_booker/data/models/daily_collection/daily_collection_create.dart';

class DailyCollectionRepositoryImpl implements DailyCollectionRepository {
  DailyCollectionRepositoryImpl(this._api);

  final DailyCollectionsApi _api;

  @override
  Future<DailyCollection> submitCollection({
    required int orderBookerId,
    required int shopId,
    required double amount,
    String? collectedAt,
    String? remarks,
    int? visitId,
  }) async {
    try {
      final request = DailyCollectionCreate(
        shopId: shopId,
        amount: amount,
        collectedAt: collectedAt,
        remarks: remarks,
        visitId: visitId,
      );
      final model = await _api.submitCollection(orderBookerId, request);
      return model.toEntity();
    } catch (e, st) {
      final failure = ApiExceptions.handle<DailyCollection>(e, st);
      throw Exception(failure.message);
    }
  }

  @override
  Future<List<DailyCollection>> getCollectionsByOrderBooker(
    int orderBookerId,
  ) async {
    try {
      final list = await _api.getCollectionsByOrderBooker(orderBookerId);
      return list.map((e) => e.toEntity()).toList();
    } catch (e, st) {
      final failure = ApiExceptions.handle<List<DailyCollection>>(e, st);
      throw Exception(failure.message);
    }
  }
}
