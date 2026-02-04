import 'package:tulip_tea_order_booker/core/network/api_exceptions.dart';
import 'package:tulip_tea_order_booker/domain/entities/product.dart';
import 'package:tulip_tea_order_booker/domain/repositories/product_repository.dart';
import 'package:tulip_tea_order_booker/data/data_sources/remote/products_api.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl(this._api);

  final ProductsApi _api;

  @override
  Future<List<Product>> getActiveProducts() async {
    try {
      final list = await _api.getActiveProducts();
      return list.map((e) => e.toEntity()).toList();
    } catch (e, st) {
      final failure = ApiExceptions.handle<List<Product>>(e, st);
      throw Exception(failure.message);
    }
  }
}
