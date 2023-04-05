import 'package:ceylife_digital/core/service/dependency_injection.dart';
import 'package:ceylife_digital/features/domain/entities/response/contact_us_response_entity.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/bloc/contact_us/contact_us_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/contact_us/contact_us_event.dart';
import 'package:ceylife_digital/features/presentation/bloc/contact_us/contact_us_state.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_appbar.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_contact_button.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_icons_icons.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_social_button.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_social_media_button.dart';
import 'package:ceylife_digital/features/presentation/views/base_view.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_constants.dart';
import 'package:ceylife_digital/utils/app_images.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

const String CEYLIFE_ADDRESS =
    'Ceylinco Life Insurance Limited,106, Havelock Road,\nColombo 5.';
const String CEYLIFE_WEB = 'https://www.ceylincolife.com/';
const String CEYLIFE_MAIL = 'care@ceylife.lk';
const String CEYLIFE_CONTACT_NO = '0112461461';
const String CEYLIFE_FAX_NO = '0112555959';
const String CEYLIFE_WHATSAPP = '0775776556';
const String CEYLIFE_VIBER = '0775776556';
const String CEYLIFE_TANGO = 'tel:0775776556';
const String CEYLIFE_SKYPE = 'skype:ceylincolifehelper';
const String CEYLIFE_FACEBOOK =
    'https://www.facebook.com/CeylincoLifeofficialpage';
const String CEYLIFE_INSTAGRAM = 'https://www.instagram.com/ceylinco_life/';
const String CEYLIFE_LINKEDIN =
    'https://www.linkedin.com/company/ceylinco-life?trk=top_nav_home';
const String CEYLIFE_YOUTUBE =
    'https://www.youtube.com/channel/UCY06S915jYyq-t3nzH0J1qQ/feed?view_as=public';

// Contact Us Codes
const ADDRESS = 'ADDRESS';
const CONTACT = 'CONTACT';
const EMAIL = 'EMAIL';
const FAX = 'FAX';
const WEB = 'WEB';
const WHATSAPP = 'WHTASAPP';
const YOUTUBE = 'YOUTUBE';
const VIBER = 'VIBER';
const LINKEDIN = 'LINKEDIN';
const INSTA = 'INSTA';

class ContactUsView extends BaseView {
  @override
  _ContactUsViewState createState() => _ContactUsViewState();
}

class _ContactUsViewState extends BaseViewState<ContactUsView> {
  final _contactUsBloc = injection<ContactUsBloc>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<ContactUsEntity> _contactUsList = List();

  void showError(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  @override
  void initState() {
    super.initState();
    _contactUsBloc.add(GetContactUsEvent());
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CeylifeAppbar(
        elevation: 0,
        title: Text(
          AppLocalizations.of(context).translate('contact_us_appbar_title'),
          style: TextStyle(color: AppColors.appBarTitle, fontSize: 18),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(AppImages.appBarBackIcon),
        ),
      ),
      body: BlocProvider<ContactUsBloc>(
        create: (_) => _contactUsBloc,
        child: BlocListener<ContactUsBloc, BaseState<ContactUsState>>(
          cubit: _contactUsBloc,
          listener: (context, state) {
            if (state is ContactUsLoaded) {
              setState(() {
                _contactUsList.clear();
                _contactUsList.addAll(state.contactUsEntity);
              });
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                        PNG_IMAGE_PATH + 'ceylife_logo_small' + PNG_TYPE,
                        height: 123,
                        width: 81),
                    SizedBox(
                      height: 13,
                    ),
                    Text(
                      AppLocalizations.of(context)
                          .translate('contact_us_head_title_label'),
                      style: TextStyle(
                        color: AppColors.primaryAshColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      _contactUsList.isNotEmpty
                          ? _queryContactValue(ADDRESS)
                          : 'Ceylinco Life Insurance Limited,106, Havelock Road,\nColombo 5.',
                      style: TextStyle(
                        color: AppColors.textColorAshDark4,
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Text(
                      AppLocalizations.of(context)
                          .translate('contact_us_contact_line_title_label'),
                      style: TextStyle(
                        color: AppColors.textColorMaroon,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      AppLocalizations.of(context)
                          .translate('contact_us_general_contact_title_label'),
                      style: TextStyle(
                        color: AppColors.textColorAshDark4,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    CeylifeContactButton(
                      iconData: Icons.call,
                      buttonText: _queryContactValue(CONTACT),
                      onTap: () => launch('tel:' + _queryContactValue(CONTACT),
                          enableJavaScript: false),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      AppLocalizations.of(context)
                          .translate('contact_us_fax_number_title_label'),
                      style: TextStyle(
                        color: AppColors.textColorAshDark4,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    CeylifeContactButton(
                      iconData: Icons.call,
                      buttonText: _queryContactValue(FAX),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      height: 2,
                      color: AppColors.dividerColor2,
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      AppLocalizations.of(context)
                          .translate('contact_us_web_email_title_label'),
                      style: TextStyle(
                        color: AppColors.textColorMaroon,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CeylifeContactButton(
                      iconData: CeylifeIcons.ic_global,
                      buttonText: _queryContactValue(WEB),
                      isContact: false,
                      onTap: () => launch(_queryContactValue(WEB),
                          enableJavaScript: false),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    CeylifeContactButton(
                      iconData: CeylifeIcons.ic_e_mail,
                      buttonText: _queryContactValue(EMAIL),
                      isContact: false,
                      onTap: () => launch('mailto:' + _queryContactValue(EMAIL),
                          enableJavaScript: false),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      height: 2,
                      color: AppColors.dividerColor2,
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      AppLocalizations.of(context)
                          .translate('contact_us_other_channels_title_label'),
                      style: TextStyle(
                        color: AppColors.textColorMaroon,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CeylifeSocialButton(
                      icon: AppImages.skype,
                      buttonText: 'ceylincolifehelper',
                      onTap: () async {
                        await canLaunch(CEYLIFE_SKYPE)
                            ? launch(CEYLIFE_SKYPE, enableJavaScript: false)
                            : showError(AppLocalizations.of(context).translate(
                                'contact_us_skype_unavailable_title_label'));
                      },
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    CeylifeSocialButton(
                      icon: AppImages.whatsapp,
                      buttonText: 'Whatsapp',
                      onTap: () async {
                        await canLaunch('whatsapp://send?phone=' +
                                _queryContactValue(WHATSAPP))
                            ? launch(
                                'whatsapp://send?phone=' +
                                    _queryContactValue(WHATSAPP),
                                enableJavaScript: false)
                            : showError(AppLocalizations.of(context).translate(
                                'contact_us_whatsapp_unavailable_title_label'));
                      },
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    CeylifeSocialButton(
                      icon: AppImages.viber,
                      buttonText: 'Viber',
                      onTap: () async {
                        await canLaunch('viber://chat?number=' +
                                _queryContactValue(VIBER))
                            ? launch(
                                'viber://chat?number=' +
                                    _queryContactValue(VIBER),
                                enableJavaScript: false)
                            : showError(AppLocalizations.of(context).translate(
                                'contact_us_viber_unavailable_title_label'));
                      },
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    CeylifeSocialButton(
                      icon: AppImages.tango,
                      buttonText: 'Tango App',
                      isTango: true,
                      onTap: () =>
                          launch(CEYLIFE_TANGO, enableJavaScript: false),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      height: 2,
                      color: AppColors.dividerColor2,
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      AppLocalizations.of(context)
                          .translate('contact_us_social_channels_title_label'),
                      style: TextStyle(
                        color: AppColors.textColorMaroon,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CeylifeSocialMediaButton(
                          onTap: () =>
                              launch(CEYLIFE_FACEBOOK, enableJavaScript: false),
                          icon: 'ic_facebook',
                        ),
                        CeylifeSocialMediaButton(
                          onTap: () => launch(_queryContactValue(INSTA),
                              enableJavaScript: false),
                          icon: AppImages.imageInstagram,
                          isIconSVG: false,
                        ),
                        CeylifeSocialMediaButton(
                          onTap: () => launch(_queryContactValue(LINKEDIN),
                              enableJavaScript: false),
                          icon: 'ic_linkedin',
                        ),
                        CeylifeSocialMediaButton(
                          onTap: () =>
                              launch(CEYLIFE_YOUTUBE, enableJavaScript: false),
                          icon: 'ic_youtube',
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _queryContactValue(String key) {
    int index = _contactUsList.indexWhere((element) => element.code == key);

    if (index < 0) {
      switch (key) {
        case ADDRESS:
          return CEYLIFE_ADDRESS;
          break;
        case CONTACT:
          return CEYLIFE_CONTACT_NO;
          break;
        case EMAIL:
          return CEYLIFE_MAIL;
          break;
        case FAX:
          return CEYLIFE_FAX_NO;
          break;
        case WEB:
          return CEYLIFE_WEB;
          break;
        case WHATSAPP:
          return CEYLIFE_WHATSAPP;
          break;
        case YOUTUBE:
          return CEYLIFE_YOUTUBE;
          break;
        case VIBER:
          return CEYLIFE_VIBER;
          break;
        case LINKEDIN:
          return CEYLIFE_LINKEDIN;
          break;
        case INSTA:
          return CEYLIFE_INSTAGRAM;
          break;
      }
    }

    return _contactUsList[index].value;
  }

  @override
  Bloc getBloc() => _contactUsBloc;
}
