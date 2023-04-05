import 'package:ceylife_digital/features/data/models/requests/verify_new_lead_generator_request.dart';

class VerifyNewLeadGeneratorRequestEntity extends VerifyNewLeadGeneratorRequest {
  VerifyNewLeadGeneratorRequestEntity(
      {this.nic,
      this.email,
      this.contactNo,
      this.contactNo2,
    })
      : super(
            nic: nic,
            email: email,
            contactNo: contactNo,
            contactNo2: contactNo,);

  String nic;
  String email;
  String contactNo;
  String contactNo2;

}
