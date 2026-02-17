import 'package:tulip_tea_mobile_app/domain/entities/product.dart';

abstract class ProductRepository {
  /// [distributorId] required for Order Bookers (backend filter).
  Future<List<Product>> getActiveProducts({int? distributorId});
}
