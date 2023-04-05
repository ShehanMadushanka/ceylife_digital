import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:ceylife_digital/core/service/app_permission.dart';
import 'package:ceylife_digital/features/domain/entities/response/product_detail_entity.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_action_button.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_app_dialog.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_appbar.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_icons_icons.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_no_border_button.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_primary_button.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_constants.dart';
import 'package:ceylife_digital/utils/app_images.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:ceylife_digital/utils/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path_provider/path_provider.dart';

class ProductPlanDetailView extends StatefulWidget {
  final ProductDetailEntity productDetail;

  const ProductPlanDetailView({Key key, this.productDetail}) : super(key: key);

  @override
  _ProductPlanDetailViewState createState() => _ProductPlanDetailViewState();
}

class _ProductPlanDetailViewState extends State<ProductPlanDetailView> {
  int progress = 0;

  ReceivePort _receivePort = ReceivePort();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static downloadingCallback(id, status, progress) {
    SendPort sendPort = IsolateNameServer.lookupPortByName("downloading");

    sendPort.send([id, status, progress]);
  }

  @override
  void initState() {
    super.initState();

    IsolateNameServer.registerPortWithName(
        _receivePort.sendPort, "downloading");

    _receivePort.listen((message) {
      setState(() {
        progress = message[2];
      });

      if (progress == 100) {
        _showLocalPushNotifications();
      }
    });

    FlutterDownloader.registerCallback(downloadingCallback);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CeylifeAppbar(
        elevation: 0,
        title: Text(
          widget.productDetail.productCategoryName,
          style: TextStyle(color: AppColors.appBarTitle, fontSize: 18),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(AppImages.appBarBackIcon),
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 22,
                      ),
                      Text(
                        'Ceylinco Life ${widget.productDetail.productName}',
                        style: TextStyle(
                          color: AppColors.textColorMaroon,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.productDetail.content,
                        style: TextStyle(
                          color: AppColors.primaryAshColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          (widget.productDetail.detailSummaryLink != null && widget.productDetail.detailSummaryLink.isNotEmpty)
                              ? Expanded(
                                  child: CeylifeActionButton(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context,
                                          Routes
                                              .PRODUCTS_SERVICES_PLAN_DETAILED_SUMMARY_VIEW,
                                          arguments: widget.productDetail);
                                    },
                                    icon: CeylifeIcons.ic_summary,
                                    label: AppLocalizations.of(context).translate(
                                        'products_services_product_illustration'),
                                  ),
                                )
                              : SizedBox.shrink(),
                          ((widget.productDetail.brochureLink != null && widget.productDetail.brochureLink.isNotEmpty) &&
                                  (widget.productDetail.detailSummaryLink != null && widget.productDetail.detailSummaryLink
                                      .isNotEmpty))
                              ? SizedBox(
                                  height: 50,
                                  child: VerticalDivider(
                                    color: AppColors.dividerColor,
                                    width: 1,
                                    thickness: 1,
                                  ),
                                )
                              : SizedBox.shrink(),
                          (widget.productDetail.brochureLink != null  && widget.productDetail.brochureLink.isNotEmpty)
                              ? Expanded(
                                  child: CeylifeActionButton(
                                    onTap: () async {
                                      if (Platform.isAndroid) {
                                        AppPermissionManager
                                            .requestExternalStoragePermission(
                                          context,
                                          () async {
                                            final _ceylifeDirectory =
                                                Directory(PDF_SAVE_PATH);
                                            if (!await _ceylifeDirectory
                                                .exists()) {
                                              _ceylifeDirectory.create();
                                            }

                                            _downloadFileFromUrl(
                                                _ceylifeDirectory.path);
                                          },
                                        );
                                      } else {
                                        Directory documents =
                                            await getApplicationDocumentsDirectory();

                                        _downloadFileFromUrl(documents.path);
                                      }
                                    },
                                    icon: CeylifeIcons.ic_download,
                                    label: AppLocalizations.of(context).translate(
                                        'products_services_download_brochure'),
                                  ),
                                )
                              : SizedBox.shrink(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                CeylifePrimaryButton(
                  buttonLabel: AppLocalizations.of(context)
                      .translate('products_services_send_inquiry'),
                  onTap: () =>
                      Navigator.pushNamed(context, Routes.CONTACT_US_VIEW),
                ),
                CeylifeNoBorderButton(
                  buttonLabel: AppConstants.IS_USER_LOGGED
                      ? AppLocalizations.of(context)
                          .translate('products_services_back_to_home')
                      : AppLocalizations.of(context)
                          .translate('products_services_back_to_login'),
                  onTap: () => Navigator.of(context).popUntil(
                      ModalRoute.withName(AppConstants.IS_USER_LOGGED
                          ? Routes.HOME_VIEW
                          : Routes.LOGIN_VIEW)),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  _showLocalPushNotifications() async {
    if (Platform.isIOS) {
      final IOSNotificationDetails iOSPlatformChannelSpecifics =
          IOSNotificationDetails();

      NotificationDetails platformChannelSpecifics =
          NotificationDetails(iOS: iOSPlatformChannelSpecifics);
      await flutterLocalNotificationsPlugin.show(
        0,
        AppConstants.appName,
        widget.productDetail.productCategoryName + ' pdf download completed',
        platformChannelSpecifics,
      );
    }
  }

  Future<void> _downloadFileFromUrl(String path) async {
    await FlutterDownloader.enqueue(
      url: widget.productDetail.brochureLink,
      savedDir: path,
      fileName:
          CEYLINCO_LIFE + " " + widget.productDetail.productName + PDF_TYPE,
      showNotification: true,
      openFileFromNotification: true,
    );
  }

  void showCeylifeDialog(
      {String title,
      String message,
      Color messageColor,
      String subDescription,
      Color subDescriptionColor,
      AlertType alertType = AlertType.SUCCESS,
      String positiveButtonText,
      String negativeButtonText,
      VoidCallback onPositiveCallback,
      VoidCallback onNegativeCallback,
      Widget dialogContentWidget,
      bool isSessionTimeout = false}) {
    showGeneralDialog(
        context: context,
        barrierDismissible: false,
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: CeyLifeAppDialog(
                title: title,
                description: message,
                descriptionColor: messageColor,
                subDescription: subDescription,
                subDescriptionColor: subDescriptionColor,
                alertType: alertType,
                positiveButtonText: positiveButtonText,
                negativeButtonText: negativeButtonText,
                onNegativeCallback: onNegativeCallback,
                onPositiveCallback: onPositiveCallback,
                dialogContentWidget: dialogContentWidget,
                isSessionTimeout: isSessionTimeout,
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {});
  }
}
