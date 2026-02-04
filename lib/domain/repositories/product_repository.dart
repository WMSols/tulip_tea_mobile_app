import 'package:tulip_tea_order_booker/domain/entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getActiveProducts();
}
