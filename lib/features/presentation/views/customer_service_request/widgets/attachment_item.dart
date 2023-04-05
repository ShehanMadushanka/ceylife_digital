import 'package:ceylife_digital/features/presentation/common/ceylife_icons_icons.dart';
import 'package:ceylife_digital/features/presentation/views/customer_service_request/data/attachment_data.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AttachmentItemUI extends StatelessWidget {
  final AttachmentData data;
  final VoidCallback onTapItem;
  final VoidCallback onRemove;

  AttachmentItemUI({this.data, this.onTapItem, this.onRemove});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: (){
        onTapItem();
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(CeylifeIcons.ic_file, color: AppColors.newsHeadlineColor, size: 28,),
            SizedBox(width: 8,),
            Expanded(
              child: Text(
                data.fileName,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                color: AppColors.newsHeadlineColor,
                fontSize: 12,
                fontWeight: FontWeight.w400
              ),),
            ),
            SizedBox(width: 6,),
            InkWell(
              highlightColor: Colors.transparent,
              focusColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: (){
                onRemove();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  AppImages.close,
                  width: 12,
                  height: 12,
                  color: AppColors.chiliRed,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
