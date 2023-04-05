class GetCsrMainCategoryResponseEntity {
  GetCsrMainCategoryResponseEntity({
    this.resCode,
    this.resError,
    this.serviceRequestMainCategoriesEntity,
  });

  String resCode;
  String resError;
  List<ServiceRequestMainCategoryEntity> serviceRequestMainCategoriesEntity;
}

class ServiceRequestMainCategoryEntity {
  ServiceRequestMainCategoryEntity({
    this.mainCategory,
    this.serviceRequestMainCategoryId,
    this.status,
  });

  String mainCategory;
  int serviceRequestMainCategoryId;
  String status;
}
