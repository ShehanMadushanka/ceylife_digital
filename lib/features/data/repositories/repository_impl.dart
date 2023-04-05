import 'package:ceylife_digital/core/network/network_info.dart';
import 'package:ceylife_digital/error/exceptions.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/error/messages.dart';
import 'package:ceylife_digital/features/data/datasources/local_data_source.dart';
import 'package:ceylife_digital/features/data/datasources/remote_data_source.dart';
import 'package:ceylife_digital/features/data/models/responses/common_error_response.dart';
import 'package:ceylife_digital/features/domain/entities/request/accumulation_rate_history_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/biometric_registration_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/branches_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/create_user_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/customer_initiated_category_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/customer_initiated_service_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/generate_payment_link_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/get_bank_branches_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/get_notification_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/health_tips_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/initiate_customer_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/key_exchange_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/login_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/notification_status_change_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/otp_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/password_reset_otp_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/password_reset_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/payment_details_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/payment_status_check_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/policy_details_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/policy_info_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/policy_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/production_detail_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/profile_data_update_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/promotions_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/register_lead_generator_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/resend_otp_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/splash_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/submit_bank_details_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/update_password_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/user_profile_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/verify_new_lead_generator_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/accumulation_rate_history_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/biometric_registration_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/branch_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/contact_us_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/create_user_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/customer_initiated_category_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/customer_initiated_service_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/faq_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/generate_payment_link_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/get_bank_branches_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/get_banks_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/get_csr_main_category_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/get_notification_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/health_tip_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/initiate_customer_service_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/key_exchange_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/login_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/news_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/otp_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/password_reset_otp_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/password_reset_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/payment_details_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/payment_status_check_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/policy_details_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/policy_info_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/policy_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/product_category_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/product_type_data_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/profile_data_update_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/promotion_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/rates_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/register_lead_generator_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/resend_otp_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/splash_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/submit_bank_details_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/update_password_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/user_profile_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/verify_new_lead_generator_response_entity.dart';
import 'package:ceylife_digital/features/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  // final EpicSureFireStoreDataSource fireStoreDataSource;
  final NetworkInfo networkInfo;

  RepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    // @required this.fireStoreDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, PromotionResponseEntity>> getPromotions(
      PromotionsRequestEntity getPostRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getPromotions(getPostRequest);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(ServerFailure(ErrorResponseModel(
            responseError: ErrorMessages().mapAPIErrorCode(
                ErrorMessages.APP_ERROR_SOMETHING_WRONG, ""))));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BranchResponseEntity>> getBranches(
      BranchesRequestEntity branchesRequestEntity) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await remoteDataSource.getBranches(branchesRequestEntity);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(ServerFailure(ErrorResponseModel(
            responseError: ErrorMessages().mapAPIErrorCode(
                ErrorMessages.APP_ERROR_SOMETHING_WRONG, ""))));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, FAQResponseEntity>> getFAQ() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getFAQ();
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(ServerFailure(ErrorResponseModel(
            responseError: ErrorMessages().mapAPIErrorCode(
                ErrorMessages.APP_ERROR_SOMETHING_WRONG, ""))));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, GetNewsResponseEntity>> getNews() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getNews();
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(ServerFailure(ErrorResponseModel(
            responseError: ErrorMessages().mapAPIErrorCode(
                ErrorMessages.APP_ERROR_SOMETHING_WRONG, ""))));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, ProductCategoryEntityResponse>>
      getProductCategories() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getProductCategories();
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(ServerFailure(ErrorResponseModel(
            responseError: ErrorMessages().mapAPIErrorCode(
                ErrorMessages.APP_ERROR_SOMETHING_WRONG, ""))));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, GetProductDetailResponseEntity>> getProductDetails(
      ProductDetailRequestEntity productDetailRequestEntity) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await remoteDataSource.getProductDetail(productDetailRequestEntity);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(ServerFailure(ErrorResponseModel(
            responseError: ErrorMessages().mapAPIErrorCode(
                ErrorMessages.APP_ERROR_SOMETHING_WRONG, ""))));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, LoginResponseEntity>> getLogin(
      LoginRequestEntity loginRequestEntity) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getLogin(loginRequestEntity);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(ServerFailure(ErrorResponseModel(
            responseError: ErrorMessages().mapAPIErrorCode(
                ErrorMessages.APP_ERROR_SOMETHING_WRONG, ""))));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, SplashResponseEntity>> splashRequest(
      SplashRequestEntity splashRequestEntity) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await remoteDataSource.splashRequest(splashRequestEntity);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(ServerFailure(ErrorResponseModel(
            responseError: ErrorMessages().mapAPIErrorCode(
                ErrorMessages.APP_ERROR_SOMETHING_WRONG, ""))));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, PolicyResponseEntity>> getPolicy(
      PolicyRequestEntity policyRequestEntity) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getPolicy(policyRequestEntity);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(ServerFailure(ErrorResponseModel(
            responseError: ErrorMessages().mapAPIErrorCode(
                ErrorMessages.APP_ERROR_SOMETHING_WRONG, ""))));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, OtpResponseEntity>> getOtp(
      OtpRequestEntity otpRequestEntity) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getOtp(otpRequestEntity);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(ServerFailure(ErrorResponseModel(
            responseError: ErrorMessages().mapAPIErrorCode(
                ErrorMessages.APP_ERROR_SOMETHING_WRONG, ""))));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, List<ContactUsEntity>>> getContactUs() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getContactUs();
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on Exception {
        return Left(ServerFailure(ErrorResponseModel(
            responseError: ErrorMessages().mapAPIErrorCode(
                ErrorMessages.APP_ERROR_SOMETHING_WRONG, ""))));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, CreateUserResponseEntity>> createUser(
      CreateUserRequestEntity createUserRequestEntity) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await remoteDataSource.createUser(createUserRequestEntity);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(ServerFailure(ErrorResponseModel(
            responseError: ErrorMessages().mapAPIErrorCode(
                ErrorMessages.APP_ERROR_SOMETHING_WRONG, ""))));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, UserProfileResponseEntity>> getUserProfile(
      UserProfileRequestEntity userProfileRequestEntity) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await remoteDataSource.getUserProfile(userProfileRequestEntity);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(ServerFailure(ErrorResponseModel(
            responseError: ErrorMessages().mapAPIErrorCode(
                ErrorMessages.APP_ERROR_SOMETHING_WRONG, ""))));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, UpdatePasswordResponseEntity>> updatePassword(
      UpdatePasswordRequestEntity updatePasswordRequestEntity) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await remoteDataSource.updatePassword(updatePasswordRequestEntity);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(ServerFailure(ErrorResponseModel(
            responseError: ErrorMessages().mapAPIErrorCode(
                ErrorMessages.APP_ERROR_SOMETHING_WRONG, ""))));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, ResendOtpResponseEntity>> resendOtp(
      ResendOtpRequestEntity resendOtpRequestEntity) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await remoteDataSource.resendOtp(resendOtpRequestEntity);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(ServerFailure(ErrorResponseModel(
            responseError: ErrorMessages().mapAPIErrorCode(
                ErrorMessages.APP_ERROR_SOMETHING_WRONG, ""))));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, ProfileDataUpdateResponseEntity>> updateProfileData(
      ProfileDataUpdateRequestEntity profileDataUpdateRequestEntity) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource
            .updateProfileData(profileDataUpdateRequestEntity);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(ServerFailure(ErrorResponseModel(
            responseError: ErrorMessages().mapAPIErrorCode(
                ErrorMessages.APP_ERROR_SOMETHING_WRONG, ""))));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, CustomerInitiatedCategoryResponseEntity>>
      getCustomerInitiatedCategories(
          CustomerInitiatedCategoryRequestEntity categoryRequestEntity) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource
            .getCustomerInitiatedCategoryServices(categoryRequestEntity);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(ServerFailure(ErrorResponseModel(
            responseError: ErrorMessages().mapAPIErrorCode(
                ErrorMessages.APP_ERROR_SOMETHING_WRONG, ""))));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, InitiateCustomerServiceResponseEntity>>
      initiateCustomerServiceRequest(
          InitiateCustomerServiceRequestEntity
              initiateCustomerServiceRequestEntity) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource
            .initiateCustomerService(initiateCustomerServiceRequestEntity);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(ServerFailure(ErrorResponseModel(
            responseError: ErrorMessages().mapAPIErrorCode(
                ErrorMessages.APP_ERROR_SOMETHING_WRONG, ""))));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, CustomerInitiatedServiceResponseEntity>>
      getCustomerInitiatedService(
          CustomerInitiatedServiceRequestEntity
              customerInitiatedServiceRequestEntity) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource
            .getCustomerInitiatedService(customerInitiatedServiceRequestEntity);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(ServerFailure(ErrorResponseModel(
            responseError: ErrorMessages().mapAPIErrorCode(
                ErrorMessages.APP_ERROR_SOMETHING_WRONG, ""))));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, PaymentDetailsResponseEntity>> getPaymentDetails(
      PaymentDetailsRequestEntity paymentDetailsRequestEntity) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource
            .getPaymentDetails(paymentDetailsRequestEntity);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(ServerFailure(ErrorResponseModel(
            responseError: ErrorMessages().mapAPIErrorCode(
                ErrorMessages.APP_ERROR_SOMETHING_WRONG, ""))));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, PolicyDetailsResponseEntity>> getPolicyDetails(
      PolicyDetailsRequestEntity policyDetailsRequestEntity) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await remoteDataSource.getPolicyDetails(policyDetailsRequestEntity);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(ServerFailure(ErrorResponseModel(
            responseError: ErrorMessages().mapAPIErrorCode(
                ErrorMessages.APP_ERROR_SOMETHING_WRONG, ""))));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, GeneratePaymentLinkResponseEntity>> getPaymentLink(
      GeneratePaymentLinkRequestEntity generatePaymentLinkRequestEntity) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource
            .getPaymentLink(generatePaymentLinkRequestEntity);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(ServerFailure(ErrorResponseModel(
            responseError: ErrorMessages().mapAPIErrorCode(
                ErrorMessages.APP_ERROR_SOMETHING_WRONG, ""))));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, PaymentStatusCheckResponseEntity>> checkPaymentStatus(
      PaymentStatusCheckRequestEntity paymentStatusCheckRequestEntity) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource
            .checkPaymentStatus(paymentStatusCheckRequestEntity);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(ServerFailure(ErrorResponseModel(
            responseError: ErrorMessages().mapAPIErrorCode(
                ErrorMessages.APP_ERROR_SOMETHING_WRONG, ""))));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, PolicyInfoResponseEntity>> getPolicyBenefitsData(
      PolicyInfoRequestEntity policyInfoRequestEntity) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource
            .getPolicyBenefitsData(policyInfoRequestEntity);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(ServerFailure(ErrorResponseModel(
            responseError: ErrorMessages().mapAPIErrorCode(
                ErrorMessages.APP_ERROR_SOMETHING_WRONG, ""))));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, PolicyInfoResponseEntity>> getPolicyLoanData(
      PolicyInfoRequestEntity policyInfoRequestEntity) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await remoteDataSource.getPolicyLoanData(policyInfoRequestEntity);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(ServerFailure(ErrorResponseModel(
            responseError: ErrorMessages().mapAPIErrorCode(
                ErrorMessages.APP_ERROR_SOMETHING_WRONG, ""))));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, GetNotificationResponseEntity>> getNotifications(
      GetNotificationRequestEntity getNotificationRequestEntity) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource
            .getNotifications(getNotificationRequestEntity);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(ServerFailure(ErrorResponseModel(
            responseError: ErrorMessages().mapAPIErrorCode(
                ErrorMessages.APP_ERROR_SOMETHING_WRONG, ""))));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, GetNotificationResponseEntity>>
      changeNotificationStatus(
          NotificationStatusChangeRequestEntity
              notificationStatusChangeRequestEntity) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource
            .changeNotificationStatus(notificationStatusChangeRequestEntity);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(ServerFailure(ErrorResponseModel(
            responseError: ErrorMessages().mapAPIErrorCode(
                ErrorMessages.APP_ERROR_SOMETHING_WRONG, ""))));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, KeyExchangeResponseEntity>> keyExchange(
      KeyExchangeRequestEntity keyExchangeRequestEntity) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await remoteDataSource.keyExchange(keyExchangeRequestEntity);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(ServerFailure(ErrorResponseModel(
            responseError: ErrorMessages().mapAPIErrorCode(
                ErrorMessages.APP_ERROR_SOMETHING_WRONG, ""))));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, HealthTipsResponseEntity>> getHealthTips(
      HealthTipsRequestEntity healthTipsRequestEntity) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await remoteDataSource.getHealthTips(healthTipsRequestEntity);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(ServerFailure(ErrorResponseModel(
            responseError: ErrorMessages().mapAPIErrorCode(
                ErrorMessages.APP_ERROR_SOMETHING_WRONG, ""))));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, AccumulationRateResponseEntity>>
      getAccumulationRate() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getAccumulationRates();
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(ServerFailure(ErrorResponseModel(
            responseError: ErrorMessages().mapAPIErrorCode(
                ErrorMessages.APP_ERROR_SOMETHING_WRONG, ""))));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, AccumulationRateHistoryResponseEntity>>
      getAccumulationRateHistory(
          AccumulationRateHistoryRequestEntity
              accumulationRateHistoryRequestEntity) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource
            .getAccumulationRateHistory(accumulationRateHistoryRequestEntity);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(ServerFailure(ErrorResponseModel(
            responseError: ErrorMessages().mapAPIErrorCode(
                ErrorMessages.APP_ERROR_SOMETHING_WRONG, ""))));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, SubmitBankDetailsResponseEntity>> submitBankDetails(
      SubmitBankDetailsRequestEntity submitBankDetailsRequestEntity) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource
            .submitBankDetails(submitBankDetailsRequestEntity);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(ServerFailure(ErrorResponseModel(
            responseError: ErrorMessages().mapAPIErrorCode(
                ErrorMessages.APP_ERROR_SOMETHING_WRONG, ""))));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BanksResponseEntity>> getBanks() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getBanks();
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on Exception {
        return Left(ServerFailure(ErrorResponseModel(
            responseError: ErrorMessages().mapAPIErrorCode(
                ErrorMessages.APP_ERROR_SOMETHING_WRONG, ""))));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, GetBankBranchesResponseEntity>> getBankBranches(
      GetBankBranchesRequestEntity getBankBranchesRequestEntity) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource
            .getBankBranches(getBankBranchesRequestEntity);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(ServerFailure(ErrorResponseModel(
            responseError: ErrorMessages().mapAPIErrorCode(
                ErrorMessages.APP_ERROR_SOMETHING_WRONG, ""))));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, VerifyNewLeadGeneratoResponseEntity>>
      verifyNewLeadGenerator(
          VerifyNewLeadGeneratorRequestEntity
              verifyNewLeadGeneratorRequestEntity) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource
            .verifyNewLeadGenerator(verifyNewLeadGeneratorRequestEntity);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(ServerFailure(ErrorResponseModel(
            responseError: ErrorMessages().mapAPIErrorCode(
                ErrorMessages.APP_ERROR_SOMETHING_WRONG, ""))));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, RegisterLeadGeneratorResponseEntity>>
      registerLeadGenerator(
          RegisterLeadGeneratorRequestEntity
              registerLeadGeneratorRequestEntity) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource
            .registerLeadGenerator(registerLeadGeneratorRequestEntity);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(ServerFailure(ErrorResponseModel(
            responseError: ErrorMessages().mapAPIErrorCode(
                ErrorMessages.APP_ERROR_SOMETHING_WRONG, ""))));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BiometricRegistrationResponseEntity>>
      biometricRegistration(
          BiometricRegistrationRequestEntity
              biometricRegistrationRequestEntity) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource
            .biometricRegistration(biometricRegistrationRequestEntity);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(ServerFailure(ErrorResponseModel(
            responseError: ErrorMessages().mapAPIErrorCode(
                ErrorMessages.APP_ERROR_SOMETHING_WRONG, ""))));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, PasswordResetOtpResponseEntity>>
      passwordResetOtpRequest(
          PasswordResetOtpRequestEntity passwordResetOtpRequestEntity) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource
            .passwordResetOtpRequest(passwordResetOtpRequestEntity);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(ServerFailure(ErrorResponseModel(
            responseError: ErrorMessages().mapAPIErrorCode(
                ErrorMessages.APP_ERROR_SOMETHING_WRONG, ""))));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, PasswordResetResponseEntity>> passwordReset(
      PasswordResetRequestEntity passwordResetRequestEntity) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await remoteDataSource.passwordReset(passwordResetRequestEntity);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(ServerFailure(ErrorResponseModel(
            responseError: ErrorMessages().mapAPIErrorCode(
                ErrorMessages.APP_ERROR_SOMETHING_WRONG, ""))));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, GetCsrMainCategoryResponseEntity>> getCSRMainCategories() async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await remoteDataSource.getCSRMainCategories();
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(ServerFailure(ErrorResponseModel(
            responseError: ErrorMessages().mapAPIErrorCode(
                ErrorMessages.APP_ERROR_SOMETHING_WRONG, ""))));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}
