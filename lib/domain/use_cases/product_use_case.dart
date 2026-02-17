import 'package:tulip_tea_mobile_app/domain/entities/product.dart';
import 'package:tulip_tea_mobile_app/domain/repositories/product_repository.dart';

class ProductUseCase {
  ProductUseCase(this._repo);
  final ProductRepository _repo;

  /// [distributorId] required for Order Bookers (GET /products/active?distributor_id=X).
  Future<List<Product>> getActiveProducts({int? distributorId}) =>
      _repo.getActiveProducts(distributorId: distributorId);
}
