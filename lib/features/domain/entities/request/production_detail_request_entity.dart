import 'package:ceylife_digital/features/data/models/requests/get_product_detail_request.dart';

class ProductDetailRequestEntity extends GetProductDetailRequest {
  final String categoryCode;

  ProductDetailRequestEntity({this.categoryCode})
      : super(categoryCode: categoryCode);
}
