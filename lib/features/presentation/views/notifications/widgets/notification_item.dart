import 'package:ceylife_digital/features/domain/entities/response/get_notification_response_entity.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_icons_icons.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_constants.dart';
import 'package:ceylife_digital/utils/app_extensions.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationItem extends StatefulWidget {
  final NotificationEntity notification;
  final VoidCallback onTap;
  final VoidCallback longPressCallback;
  final bool longPressEnabled;

  const NotificationItem(
      {Key key,
      this.notification,
      this.onTap,
      this.longPressCallback,
      this.longPressEnabled})
      : super(key: key);

  @override
  _NotificationItemState createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onLongPress: widget.longPressCallback,
      child: Container(
        height: 100,
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: widget.notification.status
              ? Colors.white.withOpacity(0.8)
              : Colors.white,
          border: widget.notification.status
              ? Border.all(
                  color: AppColors.dividerColor.withOpacity(0.8), width: 1)
              : Border(
                  left: BorderSide(
                      width: 4, color: AppColors.primaryBackgroundColor),
                  bottom: BorderSide(
                      width: 1, color: AppColors.primaryBackgroundColor),
                  top: BorderSide(
                      width: 1, color: AppColors.primaryBackgroundColor),
                  right: BorderSide(
                      width: 1, color: AppColors.primaryBackgroundColor),
                ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    _getNotificationIcon(),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      widget.notification.type.getValue(),
                      style: TextStyle(
                        color: widget.notification.status
                            ? AppColors.primaryAshColor.withOpacity(0.8)
                            : AppColors.primaryHeadingTextColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                widget.longPressEnabled
                    ? Theme(
                        data: Theme.of(context).copyWith(
                          unselectedWidgetColor:
                              AppColors.primaryBackgroundColor,
                        ),
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: Checkbox(
                              value: widget.notification.isSelected,
                              activeColor: AppColors.primaryBackgroundColor,
                              onChanged: (val) {},
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap),
                        ),
                      )
                    : SizedBox.shrink(),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.notification.title,
              style: TextStyle(
                color: widget.notification.status
                    ? AppColors.primaryBlackColor.withOpacity(0.8)
                    : AppColors.primaryBlackColor,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              DateFormat(YYYY_MM_DD_HH_mma)
                  .format(widget.notification.dateTime)
                  .toLowerCase(),
              style: TextStyle(
                color: widget.notification.status
                    ? AppColors.textColorAsh2.withOpacity(0.8)
                    : AppColors.textColorAsh2,
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getNotificationIcon() {
    switch (widget.notification.type) {
      case NotificationType.NEWS:
        return Icon(CeylifeIcons.ic_news,
            color: widget.notification.status
                ? AppColors.primaryAshColor.withOpacity(0.8)
                : AppColors.primaryBackgroundColor,
            size: 16);
      case NotificationType.PROMO:
        return Icon(CeylifeIcons.ic_promotions,
            color: widget.notification.status
                ? AppColors.primaryAshColor.withOpacity(0.8)
                : AppColors.primaryBackgroundColor,
            size: 16);
    }
  }
}
