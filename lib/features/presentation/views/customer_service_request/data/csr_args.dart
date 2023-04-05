import 'package:ceylife_digital/features/presentation/views/customer_service_request/data/attachment_data.dart';

class CSRArgs {
  String comment;
  String policyNo;
  int serviceRequestCategoryId;
  int serviceRequestMainCategoryId;
  List<AttachmentData> fileList;

  CSRArgs(
      {this.comment,
      this.policyNo,
      this.serviceRequestCategoryId,
      this.serviceRequestMainCategoryId,
      this.fileList});
}
