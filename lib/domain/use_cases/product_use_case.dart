import 'package:tulip_tea_order_booker/domain/entities/product.dart';
import 'package:tulip_tea_order_booker/domain/repositories/product_repository.dart';

class ProductUseCase {
  ProductUseCase(this._repo);
  final ProductRepository _repo;

  Future<List<Product>> getActiveProducts() => _repo.getActiveProducts();
}
