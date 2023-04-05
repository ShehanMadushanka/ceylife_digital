import 'package:ceylife_digital/core/service/dependency_injection.dart';
import 'package:ceylife_digital/features/domain/entities/response/faq_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/rates_response_entity.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/bloc/rates/rates_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/rates/rates_event.dart';
import 'package:ceylife_digital/features/presentation/bloc/rates/rates_state.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_appbar.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_empty_view.dart';
import 'package:ceylife_digital/features/presentation/common/ui_consts.dart';
import 'package:ceylife_digital/features/presentation/views/base_view.dart';
import 'package:ceylife_digital/features/presentation/views/rates/widgets/rates_expandable.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_constants.dart';
import 'package:ceylife_digital/utils/app_images.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class RatesView extends BaseView {
  @override
  _RatesViewState createState() => _RatesViewState();
}

class _RatesViewState extends BaseViewState<RatesView> {
  final bloc = injection<RatesBloc>();

  List<FAQ> faqs = List();

  List<RateEntity> _rateList = List();
  Map<String, List<RateEntity>> _ratesMap = Map();
  List<Widget> _items = List();

  @override
  void initState() {
    super.initState();
    bloc.add(GetRatesEvent());
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: CeylifeAppbar(
        elevation: 0,
        title: Text(
          AppLocalizations.of(context).translate('rates_appbar_title'),
          style: TextStyle(color: AppColors.appBarTitle, fontSize: 18),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(AppImages.appBarBackIcon),
        ),
      ),
      body: BlocProvider<RatesBloc>(
        create: (_) => bloc,
        child: BlocListener<RatesBloc, BaseState<RateState>>(
          cubit: bloc,
          listener: (context, state) {
            if (state is RatesLoadedState) {
              _rateList.clear();
              _rateList.addAll(state.accumulationRateResponseEntity.rates);
              setState(() {});
            } else if (state is RatesFailedState) {
              showCeylifeDialog(
                  title: AppLocalizations.of(context).translate('title_error'),
                  message: state.error,
                  onPositiveCallback: () {
                    Navigator.pop(context);
                  });
            }
          },
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: kBackgroundGradient,
            ),
            child: _rateList.isNotEmpty
                ? ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    children: [
                      SvgPicture.asset(
                          SVG_IMAGE_PATH + 'ceylife_logo' + SVG_TYPE),
                      SizedBox(height: 50),
                      Text(
                        AppLocalizations.of(context)
                            .translate('rates_description'),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: AppColors.textColorMaroon,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 10),
                      Column(
                        children: _rateList.isNotEmpty ? _generateViews() : [],
                      )
                    ],
                  )
                : CeylifeEmptyView(
                    status: EmptyStatus.RATE_HISTORY,
                  ),
          ),
        ),
      ),
    );
  }

  List<Widget> _generateViews() {
    Map<String, List<RateEntity>> _ratesMap = Map();

    _rateList.forEach((element) {
      _ratesMap.update(element.productCategory.productCategoryName, (value) {
        if (value == null) value = List();
        value.add(element);
        return value;
      }, ifAbsent: () {
        List<RateEntity> newRate = List();
        newRate.add(element);
        return newRate;
      });
    });

    _items.clear();

    _ratesMap.keys.forEach((element) {
      _items.add(Column(
        children: [
          RatesExpandableItem(
              categoryName: element, rateList: _ratesMap[element]),
          SizedBox(height: 20),
        ],
      ));
    });
    return _items;
  }

  @override
  Bloc getBloc() {
    return bloc;
  }
}
