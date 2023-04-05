import 'dart:ui';

import 'package:bloc/src/bloc.dart';
import 'package:ceylife_digital/core/service/dependency_injection.dart';
import 'package:ceylife_digital/error/messages.dart';
import 'package:ceylife_digital/features/domain/entities/response/get_notification_response_entity.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/bloc/notification/notification_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/notification/notification_event.dart';
import 'package:ceylife_digital/features/presentation/bloc/notification/notification_state.dart';
import 'package:ceylife_digital/features/presentation/common/app_data_provider.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_appbar.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_empty_view.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_icons_icons.dart';
import 'package:ceylife_digital/features/presentation/common/ui_consts.dart';
import 'package:ceylife_digital/features/presentation/views/base_view.dart';
import 'package:ceylife_digital/features/presentation/views/notifications/widgets/notification_item.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_constants.dart';
import 'package:ceylife_digital/utils/app_extensions.dart';
import 'package:ceylife_digital/utils/app_images.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class NotificationsView extends BaseView {
  @override
  _NotificationsViewState createState() => _NotificationsViewState();
}

class _NotificationsViewState extends BaseViewState<NotificationsView> {
  List<NotificationEntity> notifications = List();
  final _bloc = injection<NotificationBloc>();
  bool _isLongPressEnabled = false;
  List<NotificationEntity> _selectedList = List();

  @override
  void initState() {
    super.initState();
    _bloc.add(GetNotificationsEvent());
  }

  @override
  Widget buildView(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (_isLongPressEnabled) {
          _toggleLongPress();
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: Scaffold(
        appBar: CeylifeAppbar(
          elevation: 0,
          title: Text(
            AppLocalizations.of(context).translate("appbar_label_notification"),
            style: TextStyle(color: AppColors.appBarTitle, fontSize: 18),
          ),
          leading: IconButton(
            onPressed: () {
              if (_isLongPressEnabled) {
                setState(() {
                  _isLongPressEnabled = !_isLongPressEnabled;
                });
                if (!_isLongPressEnabled) {
                  notifications.forEach((element) {
                    if (element.isSelected) element.isSelected = false;
                  });
                  _selectedList.clear();
                }
              } else {
                Navigator.pop(context);
              }
            },
            icon: SvgPicture.asset(AppImages.appBarBackIcon),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: kBackgroundGradient,
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: BlocProvider<NotificationBloc>(
            create: (_) => _bloc,
            child: BlocListener<NotificationBloc, BaseState<NotificationState>>(
              listener: (_, state) {
                if (state is NotificationLoadedState) {
                  _updateNotificationCount(
                      state.getNotificationResponseEntity.notifications);
                } else if (state is NotificationStatusChangeSuccessState) {
                  _updateNotificationCount(
                      state.getNotificationResponseEntity.notifications);
                } else {
                  _reset();
                }
              },
              cubit: _bloc,
              child: Stack(
                children: [
                  (notifications.isNotEmpty)
                      ? Padding(
                          padding:
                              EdgeInsets.only(top: 20, left: 12, right: 12),
                          child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (_, index) =>
                                (index == notifications.length - 1)
                                    ? Column(
                                        children: [
                                          _getNotificationItem(index),
                                          _isLongPressEnabled
                                              ? SizedBox(height: 90)
                                              : SizedBox(height: 10),
                                        ],
                                      )
                                    : _getNotificationItem(index),
                            itemCount: notifications.length,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    SizedBox(height: 8),
                          ),
                        )
                      : CeylifeEmptyView(status: EmptyStatus.NOTIFICATIONS),
                  _isLongPressEnabled
                      ? Align(
                          alignment: Alignment.bottomCenter,
                          child: ClipRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                              child: Container(
                                height: 80,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 13, horizontal: 10),
                                decoration:
                                    BoxDecoration(color: Color(0xE5FFFFFF)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    BottomAction(
                                      icon: CeylifeIcons.ic_select_all,
                                      label: AppLocalizations.of(context)
                                          .translate("button_label_select_all"),
                                      onTap: () {
                                        _selectedList.clear();
                                        if (!notifications.any(
                                            (element) => !element.isSelected)) {
                                          notifications.forEach((element) {
                                            element.isSelected = false;
                                          });
                                        } else {
                                          notifications.forEach((element) {
                                            element.isSelected = true;
                                          });
                                          _selectedList.addAll(notifications);
                                        }
                                        setState(() {});
                                      },
                                    ),
                                    BottomAction(
                                      icon: CeylifeIcons.ic_mark_read,
                                      label: AppLocalizations.of(context)
                                          .translate("button_label_mark_read"),
                                      onTap: () {
                                        if (_selectedList.isNotEmpty) {
                                          _bloc.add(
                                              ChangeNotificationStatusEvent(
                                                  status: AppConstants
                                                      .STATUS_NOTIFICATION_READ,
                                                  idList: _selectedList
                                                      .map((e) =>
                                                          e.notificationReadId)
                                                      .toList()));
                                        }
                                      },
                                    ),
                                    BottomAction(
                                      icon: CeylifeIcons.ic_delete,
                                      label: AppLocalizations.of(context)
                                          .translate("button_label_delete"),
                                      onTap: () => _selectedList.isNotEmpty
                                          ? showCeylifeDialog(
                                              title: AppLocalizations
                                                      .of(context)
                                                  .translate(
                                                      "label_delete_confirmation"),
                                              message: ErrorMessages()
                                                  .mapAPIErrorCode(
                                                      ErrorMessages
                                                          .APP_NOTIFICATION_MULTIPLE_DELETE,
                                                      _selectedList.length
                                                          .toString()),
                                              positiveButtonText:
                                                  AppLocalizations.of(context)
                                                      .translate(
                                                          "button_label_delete"),
                                              negativeButtonText:
                                                  AppLocalizations.of(context)
                                                      .translate(
                                                          "button_label_back"),
                                              onPositiveCallback: () {
                                                if (_selectedList.isNotEmpty) {
                                                  _bloc.add(ChangeNotificationStatusEvent(
                                                      status: AppConstants
                                                          .STATUS_NOTIFICATION_DELETE,
                                                      idList: _selectedList
                                                          .map((e) => e
                                                              .notificationReadId)
                                                          .toList()));
                                                }
                                                _reset();
                                              })
                                          : () {},
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      : SizedBox.shrink()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _updateNotificationCount(List<NotificationEntity> notificationList) {
    notifications.clear();
    setState(() {
      notifications.addAll(notificationList);
      notifications.sort((n1, n2) => n2.dateTime.compareTo(n1.dateTime));
    });
    context
        .read<AppDataProvider>()
        .updateCount(notifications.where((element) => !element.status).length);
  }

  NotificationItem _getNotificationItem(int index) => NotificationItem(
        notification: notifications[index],
        onTap: () {
          if (_isLongPressEnabled) {
            setState(() {
              notifications[index].isSelected =
                  !notifications[index].isSelected;
            });
            if (_selectedList.contains(notifications[index])) {
              _selectedList.remove(notifications[index]);
            } else {
              _selectedList.add(notifications[index]);
            }
          } else {
            if (notifications[index].status) {
              _viewNotification(index);
            } else {
              _bloc.add(ChangeNotificationStatusEvent(
                  status: AppConstants.STATUS_NOTIFICATION_READ,
                  idList: [notifications[index].notificationReadId]));
              _viewNotification(index);
            }
          }
        },
        longPressCallback: _toggleLongPress,
        longPressEnabled: _isLongPressEnabled,
      );

  _reset() {
    _selectedList.clear();
    _isLongPressEnabled = false;
  }

  _toggleLongPress() {
    setState(() {
      _isLongPressEnabled = !_isLongPressEnabled;
    });
    if (!_isLongPressEnabled) {
      notifications.forEach((element) {
        if (element.isSelected) element.isSelected = false;
      });
      _selectedList.clear();
    }
  }

  _viewNotification(int index) {
    showCeylifeDialog(
      title: notifications[index].title,
      positiveButtonText: AppLocalizations.of(context).translate("close_label"),
      onPositiveCallback: () {},
      dialogContentWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _getNotificationIcon(index),
              SizedBox(
                width: 8,
              ),
              Text(
                notifications[index].type.getValue(),
                style: TextStyle(
                  color: AppColors.primaryHeadingTextColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            DateFormat(YYYY_MM_DD_HH_mma)
                .format(notifications[index].dateTime)
                .toLowerCase(),
            style: TextStyle(
              color: AppColors.textColorAsh2,
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            notifications[index].description,
            style: TextStyle(
              color: AppColors.primaryAshColor,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  _getNotificationIcon(int index) {
    switch (notifications[index].type) {
      case NotificationType.NEWS:
        return Icon(CeylifeIcons.ic_news,
            color: AppColors.primaryBackgroundColor, size: 16);
      case NotificationType.PROMO:
        return Icon(CeylifeIcons.ic_promotions,
            color: AppColors.primaryBackgroundColor, size: 16);
    }
  }

  @override
  Bloc getBloc() => _bloc;
}

class BottomAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const BottomAction({Key key, this.icon, this.label, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: Color(0xffBB7577), size: 20),
          SizedBox(
            height: 8,
          ),
          Text(
            label,
            maxLines: 2,
            style: TextStyle(
              color: AppColors.primaryBlackColor,
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
