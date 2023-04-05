import 'package:ceylife_digital/features/domain/entities/response/faq_response_entity.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_icons_icons.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_outline_button.dart';
import 'package:ceylife_digital/features/presentation/common/expandable.dart';
import 'package:ceylife_digital/features/presentation/views/contact_us/contact_us_view.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FAQExpandableItem extends StatelessWidget {
  final FAQ faq;

  const FAQExpandableItem({Key key, this.faq}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      child: ScrollOnExpand(
        scrollOnExpand: false,
        scrollOnCollapse: true,
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            ScrollOnExpand(
              scrollOnExpand: true,
              scrollOnCollapse: true,
              child: ExpandableNotifier(
                initialExpanded: false,
                child: ExpandablePanel(
                  iconColor: AppColors.primaryBackgroundColor,
                  tapHeaderToExpand: true,
                  tapBodyToCollapse: true,
                  headerAlignment: ExpandablePanelHeaderAlignment.top,
                  header: Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            faq.question,
                            style: TextStyle(
                              color: AppColors.primaryBlackColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            textAlign: TextAlign.start,
                          ),
                        )
                      ],
                    ),
                  ),
                  expanded: MediaQuery.removePadding(
                    context: context,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Column(
                            children: [
                              Text(
                                faq.answer,
                                softWrap: true,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.primaryAshColor,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [_getReferenceLink()],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  builder: (_, collapsed, expanded) {
                    return Column(
                      children: <Widget>[
                        Padding(
                          padding:
                              EdgeInsets.only(left: 20, right: 20, bottom: 10),
                          child: Expandable(
                            collapsed: collapsed,
                            expanded: expanded,
                            crossFadePoint: 0,
                          ),
                        ),
                        Divider(
                          height: 2,
                          color: AppColors.dividerColor,
                          thickness: 1,
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getReferenceLink() {
    if (faq.linkReference == AppConstants.FAQ_REF_WEB && faq.link != null) {
      return CeylifeOutlineButton(
        leading: CeylifeIcons.ic_link,
        text: 'Visit Website',
        onTap: () {
          launch(faq.link, enableJavaScript: false);
        },
      );
    } else if (faq.linkReference == AppConstants.FAQ_REF_EMAIL &&
        faq.link != null) {
      return CeylifeOutlineButton(
        leading: CeylifeIcons.ic_e_mail,
        text: 'E-Mail',
        onTap: () {
          launch('mailto:' + faq.link, enableJavaScript: false);
        },
      );
    } else if (faq.linkReference == AppConstants.FAQ_REF_TEL &&
        faq.link != null) {
      return CeylifeOutlineButton(
        leading: Icons.call,
        text: faq.link,
        onTap: () {
          launch('tel:' + faq.link, enableJavaScript: false);
        },
      );
    } else {
      return CeylifeOutlineButton(
        leading: CeylifeIcons.ic_link,
        text: 'Visit Website',
        onTap: () {
          launch(CEYLIFE_WEB, enableJavaScript: false);
        },
      );
    }
  }
}
