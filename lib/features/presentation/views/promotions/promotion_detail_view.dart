import 'package:ceylife_digital/core/service/dependency_injection.dart';
import 'package:ceylife_digital/error/messages.dart';
import 'package:ceylife_digital/features/domain/entities/response/promotion_response_entity.dart';
import 'package:ceylife_digital/features/presentation/bloc/promotions_bloc/promotions_bloc.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_appbar.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_icons_icons.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_outline_button.dart';
import 'package:ceylife_digital/features/presentation/common/image_loading_indicator.dart';
import 'package:ceylife_digital/features/presentation/views/base_view.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_images.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class PromotionDetailView extends BaseView {
  final PromotionsEntity _promotionsResponseEntity;

  PromotionDetailView(this._promotionsResponseEntity);

  @override
  _PromotionDetailViewState createState() =>
      _PromotionDetailViewState(_promotionsResponseEntity);
}

class _PromotionDetailViewState extends BaseViewState<PromotionDetailView> {
  final promotionsBloc = injection<PromotionsBloc>();
  final PromotionsEntity _promotionsResponseEntity;

  _PromotionDetailViewState(this._promotionsResponseEntity);

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: CeylifeAppbar(
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)
              .translate("promotion_detail_appbar_title"),
          style: TextStyle(color: AppColors.appBarTitle, fontSize: 18),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(AppImages.appBarBackIcon),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Text("${_promotionsResponseEntity.title}",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: AppColors.primaryHeadingTextColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 18)),
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Text(
                  ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_VALID_TILL,
                      '${_promotionsResponseEntity.validDate} , ${_promotionsResponseEntity.validTime}'),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: AppColors.textColorAmber,
                      fontWeight: FontWeight.w500,
                      fontSize: 14)),
            ),
            SizedBox(height: 16),
            _promotionsResponseEntity.imageURL == null
                ? SizedBox()
                : Image.network(
                    _promotionsResponseEntity.imageURL,
                    fit: BoxFit.fill,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) return child;
                      return ImageLoadingIndicator(
                          loadingProgress: loadingProgress);
                    },
                  ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Text.rich(TextSpan(
                  text: "${_promotionsResponseEntity.description}",
                  style: TextStyle(
                      color: AppColors.primaryAshColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  children: [
                    TextSpan(
                        text: AppLocalizations.of(context)
                            .translate("promotions_tnc_apply"),
                        style: TextStyle(
                            color: AppColors.textColorAsh,
                            fontSize: 12,
                            fontWeight: FontWeight.w400))
                  ])),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 12.0, bottom: 22, right: 12, left: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                      AppLocalizations.of(context)
                          .translate("promotions_for_more_details"),
                      style: TextStyle(
                          color: AppColors.textColorAmber,
                          fontWeight: FontWeight.w500,
                          fontSize: 14)),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      CeylifeOutlineButton(
                        leading: Icons.call,
                        text: _promotionsResponseEntity.contactNumber,
                        onTap: () {
                          UrlLauncher.launch(
                              "tel://${_promotionsResponseEntity.contactNumber}", enableJavaScript: false);
                        },
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      CeylifeOutlineButton(
                        leading: CeylifeIcons.ic_link,
                        text: AppLocalizations.of(context)
                            .translate("visit_website_label"),
                        onTap: () async {
                          UrlLauncher.launch(_promotionsResponseEntity.link, enableJavaScript: false);
                          /*if(await UrlLauncher.canLaunch('www.google.com'))
                            UrlLauncher.canLaunch('www.google.com');
                          else
                            showMessageDialog(context, title: "Error", message: "Cannot launch");*/
                        },
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Bloc getBloc() {
    return promotionsBloc;
  }
}
