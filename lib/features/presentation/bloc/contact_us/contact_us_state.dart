import 'package:ceylife_digital/features/domain/entities/response/contact_us_response_entity.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';

abstract class ContactUsState extends BaseState<ContactUsState> {}

class ContactUsLoaded extends ContactUsState {
  final List<ContactUsEntity> contactUsEntity;

  ContactUsLoaded(this.contactUsEntity);
}
