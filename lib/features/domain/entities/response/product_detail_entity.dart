import 'package:equatable/equatable.dart';

class ProductDetailEntity extends Equatable {
  int productId;
  final String productName;
  String productCategoryName;
  final String content;
  String detailSummaryLink;
  String brochureLink;
  String status;

  ProductDetailEntity(this.productName, this.content, this.detailSummaryLink,
      this.brochureLink);

  @override
  List<Object> get props => [productId, productName, productCategoryName];
}
