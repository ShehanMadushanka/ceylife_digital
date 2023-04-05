import 'package:ceylife_digital/core/service/dependency_injection.dart';
import 'package:ceylife_digital/features/domain/entities/response/faq_response_entity.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/bloc/faq/faq_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/faq/faq_event.dart';
import 'package:ceylife_digital/features/presentation/bloc/faq/faq_state.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_appbar.dart';
import 'package:ceylife_digital/features/presentation/views/base_view.dart';
import 'package:ceylife_digital/features/presentation/views/faq/widgets/faq_expandable.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_images.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class FAQView extends BaseView {
  @override
  _FAQViewState createState() => _FAQViewState();
}

class _FAQViewState extends BaseViewState<FAQView> {
  final faqBloc = injection<FAQBloc>();

  List<FAQ> faqs = List();

  @override
  void initState() {
    super.initState();
    faqBloc.add(GetFAQEvent());
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: CeylifeAppbar(
        elevation: 0,
        title: Text(
          AppLocalizations.of(context).translate("faq_appbar_title"),
          style: TextStyle(color: AppColors.appBarTitle, fontSize: 18),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(AppImages.appBarBackIcon),
        ),
      ),
      body: BlocProvider<FAQBloc>(
        create: (_) => faqBloc,
        child: BlocListener<FAQBloc, BaseState<FAQState>>(
          cubit: faqBloc,
          listener: (context, state) {
            if (state is FAQLoadedState) {
              faqs.clear();
              faqs.addAll(state.faqResponseEntity.faqData);
              faqs.sort((a,b)=>a.sortedKey.compareTo(b.sortedKey));
              setState(() {});
            } else if (state is FAQFailedState) {
              showCeylifeDialog(
                  title: AppLocalizations.of(context).translate('title_error'),
                  message: state.error,
                  onPositiveCallback: (){
                    Navigator.pop(context);
                  }
              );
            }
          },
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 10),
                Text(AppLocalizations.of(context).translate("faq_top_heading"),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.primaryHeadingTextColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 18)),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image(image: AssetImage(AppImages.faqTopImage)),
                ),
                Divider(
                  height: 2,
                  color: AppColors.dividerColor,
                  thickness: 1,
                ),
                Column(
                  children: _getFAQList(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<FAQExpandableItem> _getFAQList() {
    List<FAQExpandableItem> _faqItems = List();

    faqs.forEach((element) {
      _faqItems.add(FAQExpandableItem(
        faq: element,
      ));
    });

    return _faqItems;
  }

  @override
  Bloc getBloc() {
    return faqBloc;
  }
}
