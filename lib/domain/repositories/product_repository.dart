import 'package:tulip_tea_mobile_app/domain/entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getActiveProducts();
}
