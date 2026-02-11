import 'package:tulip_tea_mobile_app/domain/entities/product.dart';
import 'package:tulip_tea_mobile_app/domain/repositories/product_repository.dart';

class ProductUseCase {
  ProductUseCase(this._repo);
  final ProductRepository _repo;

  Future<List<Product>> getActiveProducts() => _repo.getActiveProducts();
}
