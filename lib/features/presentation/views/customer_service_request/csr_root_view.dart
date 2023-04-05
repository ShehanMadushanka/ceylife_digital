import 'package:ceylife_digital/core/service/dependency_injection.dart';
import 'package:ceylife_digital/features/domain/entities/response/customer_initiated_category_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/customer_initiated_service_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/get_csr_main_category_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/policy_details_response_entity.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/bloc/customer_service_request/customer_service_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/customer_service_request/customer_service_event.dart';
import 'package:ceylife_digital/features/presentation/bloc/customer_service_request/customer_service_state.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_anim_widget.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_appbar.dart';
import 'package:ceylife_digital/features/presentation/common/ui_consts.dart';
import 'package:ceylife_digital/features/presentation/views/base_view.dart';
import 'package:ceylife_digital/features/presentation/views/customer_service_request/widgets/csr_new_request.dart';
import 'package:ceylife_digital/features/presentation/views/customer_service_request/widgets/csr_previous_request_view.dart';
import 'package:ceylife_digital/utils/app_animation.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_constants.dart';
import 'package:ceylife_digital/utils/app_images.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:ceylife_digital/utils/navigation_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CustomerServiceRequestRootView extends BaseView {
  final bool isFromProfileUI;

  CustomerServiceRequestRootView({this.isFromProfileUI = false});

  @override
  _CustomerServiceRequestRootViewState createState() =>
      _CustomerServiceRequestRootViewState();
}

const NEW_REQUEST_VIEW = 0;
const PREVIOUS_REQUESTS_VIEW = 1;

class _CustomerServiceRequestRootViewState
    extends BaseViewState<CustomerServiceRequestRootView>
    with TickerProviderStateMixin {
  TabController _tabController;
  List<CustomerInitiatedServiceRequestDetailEntity> _previousRequests = List();
  List<ServiceRequestMainCategoryEntity> serviceRequestMainCategoriesEntity =
      List();
  List<ServiceRequestCategoryEntity> serviceRequestCategoriesEntity = List();
  List<PolicyDetailItemEntity> policyDetailsList = List();
  AnimationController _animationController;

  List<Widget> _getBody() => [
        CSRNewRequestView(
          serviceRequestMainCategoriesEntity:
              serviceRequestMainCategoriesEntity,
          policyDetailsList: policyDetailsList,
          onTapMainCategory: (categoryId) {
            _csrBloc.add(
                GetCustomerInitiatedCategoriesEvent(categoryId: categoryId));
          },
          onError: (error) {
            showCeylifeDialog(
                title: AppLocalizations.of(context).translate('title_error'),
                message: error);
          },
          onSubmit: (csrArgs) {
            _csrBloc.add(
              InitiateCustomerServiceEvent(
                  requestType: AppConstants.SERVICE_REQUEST_CUSTOMER,
                  serviceRequestCategoryId: csrArgs.serviceRequestCategoryId,
                  comment: csrArgs.comment,
                  fileList: csrArgs.fileList,
                  policyNo: csrArgs.policyNo,
                  serviceRequestMainCategoryId:
                      csrArgs.serviceRequestMainCategoryId),
            );
          },
          shouldContactAdministration: () {
            showCeylifeDialog(
              title: AppLocalizations.of(context)
                  .translate('customer_service_request'),
              positiveButtonText:
                  AppLocalizations.of(context).translate('ok_label'),
              onPositiveCallback: () {},
              alertType: AlertType.FAIL,
              message: AppLocalizations.of(context)
                  .translate('csr_admin_required_desc'),
              dialogContentWidget: Column(
                children: [
                  CeylifeAnimWidget(
                      controller: _animationController,
                      anim: AppAnimation.animFailed)
                ],
              ),
            );
          },
          validateCharacterCallback: (message) {
            showCeylifeDialog(
              title: AppLocalizations.of(context).translate('title_error'),
              positiveButtonText:
                  AppLocalizations.of(context).translate('ok_label'),
              onPositiveCallback: () {},
              alertType: AlertType.FAIL,
              message: message,
            );
          },
          serviceRequestCategoriesEntity: serviceRequestCategoriesEntity,
        ),
        CSRPreviousRequestsView(
          previousRequests: _previousRequests,
          refreshCallback: () => _csrBloc
              .add(GetCustomerInitiatedServicesEvent(isInitialRequest: false)),
        )
      ];

  final _csrBloc = injection<CustomerServiceBloc>();

  @override
  void initState() {
    _tabController = TabController(length: _getBody().length, vsync: this);
    _tabController.addListener(_handleTabSelection);
    _animationController = AnimationController(vsync: this);
    if (widget.isFromProfileUI)
      _tabController.index = 1;
    else {
      _csrBloc.add(GetCustomerInitiatedServicesEvent(isInitialRequest: true));
    }
    super.initState();
  }

  void _handleTabSelection() {
    if (!_tabController.indexIsChanging) {
      if (_tabController.index != _tabController.previousIndex) {
        switch (_tabController.index) {
          case 0:
            _csrBloc.add(GetPoliciesEvent());
            break;
          case 1:
            _csrBloc.add(
                GetCustomerInitiatedServicesEvent(isInitialRequest: false));
            break;
          default:
            break;
        }
      } else {
        switch (_tabController.index) {
          case 0:
            _csrBloc.add(GetPoliciesEvent());
            break;
          case 1:
            _csrBloc.add(
                GetCustomerInitiatedServicesEvent(isInitialRequest: false));
            break;
          default:
            break;
        }
      }
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget buildView(BuildContext context) {
    return RefreshConfiguration(
      headerBuilder: () => WaterDropMaterialHeader(),
      enableScrollWhenRefreshCompleted: true,
      enableLoadingWhenFailed: true,
      child: Scaffold(
        appBar: CeylifeAppbar(
          elevation: 0,
          title: Text(
            AppLocalizations.of(context).translate("customer_service_request"),
            style: TextStyle(color: AppColors.appBarTitle, fontSize: 18),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset(AppImages.appBarBackIcon),
          ),
        ),
        body: BlocProvider<CustomerServiceBloc>(
          create: (_) => _csrBloc,
          child: BlocListener<CustomerServiceBloc,
              BaseState<CustomerServiceState>>(
            cubit: _csrBloc,
            listener: (context, state) {
              if (state is CustomerInitiatedCategoriesSuccessState) {
                serviceRequestCategoriesEntity.clear();
                serviceRequestCategoriesEntity.addAll(
                    state.categoryResponseEntity.serviceRequestCategories);
                setState(() {});
              } else if (state is PreviousRequestsSuccessState) {
                if (state.isInitialRequest) {
                  _csrBloc.add(GetPoliciesEvent());
                } else {
                  _previousRequests.clear();
                  setState(() {
                    _previousRequests.addAll(state
                        .customerInitiatedServiceResponseEntity
                        .customerInitiatedServiceRequestDetails);
                  });
                }
              } else if (state is RequestPendingErrorState) {
                showCeylifeDialog(
                  title: AppLocalizations.of(context)
                      .translate('title_previous_request_pending'),
                  positiveButtonText:
                      AppLocalizations.of(context).translate('ok_label'),
                  onPositiveCallback: () {},
                  alertType: AlertType.FAIL,
                  message:
                      '${AppLocalizations.of(context).translate('label_previous_request_pending_desc_sorry')} ${state.nickname}, ${AppLocalizations.of(context).translate('label_previous_request_pending_desc_2_sorry')}',
                  dialogContentWidget: Column(
                    children: [
                      CeylifeAnimWidget(
                          controller: _animationController,
                          anim: AppAnimation.animFailed)
                    ],
                  ),
                );
              } else if (state is PreviousRequestsFailedState) {
              } else if (state is InitiateCustomerServiceSuccessState) {
                showCeylifeDialog(
                  title: AppLocalizations.of(context)
                      .translate('title_request_submitted'),
                  positiveButtonText: AppLocalizations.of(context)
                      .translate('got_it_button_label'),
                  onPositiveCallback: () {
                    setState(() {
                      Navigator.popAndPushNamed(
                          context, Routes.CUSTOMER_SERVICE_REQUEST_ROOT_VIEW);
                    });
                  },
                  message: AppLocalizations.of(context)
                      .translate('label_request_submitted'),
                  dialogContentWidget: Column(
                    children: [
                      CeylifeAnimWidget(
                          controller: _animationController,
                          anim: AppAnimation.animSuccess)
                    ],
                  ),
                );
              } else if (state is CSRMainCategoriesSuccessState) {
                setState(() {
                  serviceRequestMainCategoriesEntity.clear();
                  serviceRequestMainCategoriesEntity.addAll(state
                      .getCsrMainCategoryResponseEntity
                      .serviceRequestMainCategoriesEntity);
                });
              } else if (state is PolicyLoadedState) {
                policyDetailsList.clear();
                policyDetailsList
                    .addAll(state.policyDetailsResponseEntity.data);
                _csrBloc.add(GetCSRMainCategoriesEvent());
              } else if (state is PolicyLoadingFailedState) {
                showCeylifeDialog(
                    title:
                        AppLocalizations.of(context).translate('title_error'),
                    message: state.error,
                    onPositiveCallback: () {
                      Navigator.pop(context);
                    });
              }
            },
            child: Container(
              decoration: BoxDecoration(
                gradient: kBackgroundGradient,
              ),
              child: Column(
                children: [
                  Container(
                    height: 55,
                    decoration: BoxDecoration(
                      color: AppColors.primaryBackgroundColor,
                      border: Border.all(color: Color(0xff790013), width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x40000000),
                          blurRadius: 5,
                          offset: Offset(0, 4),
                        )
                      ],
                    ),
                    child: TabBar(
                      controller: _tabController,
                      indicator: BoxDecoration(
                        color: Colors.white,
                      ),
                      labelColor: AppColors.primaryBackgroundColor,
                      unselectedLabelColor: Colors.white,
                      tabs: [
                        Tab(
                          child: Text(
                            AppLocalizations.of(context)
                                .translate("new_request_label"),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            AppLocalizations.of(context)
                                .translate("previous_requests_label"),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // tab bar view here
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: _getBody(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Bloc getBloc() => _csrBloc;
}
