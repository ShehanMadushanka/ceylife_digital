import 'package:ceylife_digital/core/usecase/usecase.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/error/messages.dart';
import 'package:ceylife_digital/features/data/models/responses/common_error_response.dart';
import 'package:ceylife_digital/features/domain/usecases/use_case_get_contact_us.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/bloc/contact_us/contact_us_event.dart';
import 'package:ceylife_digital/features/presentation/bloc/contact_us/contact_us_state.dart';
import 'package:ceylife_digital/utils/app_constants.dart';

import '../base_bloc.dart';

class ContactUsBloc
    extends BaseBloc<ContactUsEvent, BaseState<ContactUsState>> {
  final UseCaseGetContactUs usecaseGetContactUs;

  ContactUsBloc({this.usecaseGetContactUs}) : super(APILoadingState());

  @override
  Stream<BaseState<ContactUsState>> mapEventToState(
      ContactUsEvent event) async* {
    if (event is GetContactUsEvent) {
      yield APILoadingState();
      final result = await usecaseGetContactUs(NoParams());
      yield result.fold((l) {
        if (l is AuthorizedFailure) {
          if (AppConstants.IS_USER_LOGGED)
            return SessionExpireState();
          else
            return APIFailureState(
                errorResponseModel: ErrorResponseModel(
                    responseError: ErrorMessages().mapFailureToMessage(l)));
        } else
          return APIFailureState(
              errorResponseModel: ErrorResponseModel(
                  responseError: ErrorMessages().mapFailureToMessage(l)));
      }, (r) => ContactUsLoaded(r));
    }
  }
}
