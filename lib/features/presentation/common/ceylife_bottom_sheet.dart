import 'dart:ui';

import 'package:ceylife_digital/features/presentation/views/common/data/bottom_sheet_data.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_images.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CeylifeBottomSheet extends StatefulWidget {
  final Function(BottomSheetData) callback;
  final List<BottomSheetData> dataList;
  final int selectedIndex;
  final String title;
  final double height;
  final bool isSearchable;
  final bool isDividerAvailable;
  final bool shouldBoldText;
  final bool getSelectOnTap;

  CeylifeBottomSheet(
      {Key key,
      this.dataList,
      this.callback,
      this.selectedIndex = -1,
      this.title,
      this.height,
      this.shouldBoldText = false,
      this.isDividerAvailable = false,
      this.getSelectOnTap = false,
      this.isSearchable})
      : super(key: key);

  @override
  _CeylifeBottomSheetState createState() => _CeylifeBottomSheetState();
}

class _CeylifeBottomSheetState extends State<CeylifeBottomSheet> {
  ValueNotifier<int> selectedIndexNotifier = ValueNotifier<int>(-1);
  BottomSheetData bottomSheetData;
  final TextEditingController _searchController = TextEditingController();
  String filter;

  @override
  void initState() {
    selectedIndexNotifier.value = widget.selectedIndex;
    super.initState();
    _searchController.addListener(() {
      setState(() {
        filter = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedIndexNotifier,
      builder: (context, int value, child) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          color: Colors.white,
          height: widget.height,
          child: Padding(
            padding: EdgeInsets.only(top: widget.isSearchable ? 50 : 0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                widget.title != null
                    ? Stack(
                        children: [
                          Positioned(
                            top: 14,
                            left: 10,
                            right: 10,
                            child: Text(
                              widget.title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.textColorMaroon,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                  bottomSheetData = (selectedIndexNotifier
                                              .value >=
                                          0)
                                      ? widget
                                          .dataList[selectedIndexNotifier.value]
                                      : null;
                                  widget.callback(bottomSheetData);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: SvgPicture.asset(
                                    AppImages.close,
                                    width: 17,
                                    height: 17,
                                    color: AppColors.chiliRed,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : SizedBox.shrink(),
                widget.isSearchable
                    ? Container(
                        padding: EdgeInsets.all(20),
                        child: TextField(
                          controller: _searchController,
                          maxLengthEnforced: false,
                          textInputAction: TextInputAction.search,
                          cursorColor: AppColors.appHighlightColor,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.primaryBackgroundColor)),
                              hintText: AppLocalizations.of(context)
                                  .translate("label_bottom_sheet_search"),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.primaryBackgroundColor)),
                              hintStyle: TextStyle(
                                  fontSize: 18,
                                  color: AppColors.textColorAsh,
                                  fontWeight: FontWeight.w400),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.primaryBackgroundColor),
                              ),
                              suffixIcon: Icon(
                                Icons.search,
                                color: AppColors.dividerColor,
                                size: 18,
                              )),
                          style: TextStyle(
                              fontSize: 18,
                              color: AppColors.primaryTextColor,
                              fontWeight: FontWeight.w400),
                        ),
                      )
                    : SizedBox.shrink(),
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: selectedIndexNotifier,
                    builder: (context, value, child) => ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: widget.dataList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return filter == null || filter == ""
                            ? ListTile(
                                onTap: () {
                                  selectedIndexNotifier.value = index;
                                  bottomSheetData = widget.dataList[index];
                                  if (widget.getSelectOnTap) {
                                    widget.callback(bottomSheetData);
                                  }
                                },
                                key: Key(index.toString()),
                                title: Column(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 5,
                                        ),
                                        value == index
                                            ? Flexible(
                                                child: Text(
                                                  widget.dataList[index]
                                                      .description,
                                                  style: TextStyle(
                                                    fontFamily: widget
                                                        .dataList[index]
                                                        .fontFamily,
                                                    color: AppColors
                                                        .textColorMaroon,
                                                    fontSize:
                                                        widget.shouldBoldText
                                                            ? 21
                                                            : 18,
                                                    fontWeight:
                                                        widget.shouldBoldText
                                                            ? FontWeight.w500
                                                            : FontWeight.w400,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              )
                                            : Flexible(
                                                child: Text(
                                                  widget.dataList[index]
                                                      .description,
                                                  style: TextStyle(
                                                    fontFamily: widget
                                                        .dataList[index]
                                                        .fontFamily,
                                                    color: Colors.black,
                                                    fontSize:
                                                        widget.shouldBoldText
                                                            ? 21
                                                            : 18,
                                                    fontWeight:
                                                        widget.shouldBoldText
                                                            ? FontWeight.w500
                                                            : FontWeight.w400,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                        SizedBox(
                                          width: 12.17,
                                        ),
                                        value == index
                                            ? SvgPicture.asset(
                                                AppImages.icRightMark,
                                                width: 16,
                                                height: 12,
                                              )
                                            : SizedBox(),
                                      ],
                                    ),
                                    (widget.isDividerAvailable)
                                        ? Padding(
                                            padding:
                                                const EdgeInsets.only(top: 16),
                                            child: (widget.dataList.length -
                                                        1 !=
                                                    index)
                                                ? Divider(
                                                    height: 1,
                                                    color:
                                                        AppColors.dividerColor,
                                                  )
                                                : SizedBox.shrink(),
                                          )
                                        : SizedBox.shrink()
                                  ],
                                ),
                              )
                            : widget.dataList[index].description
                                    .toLowerCase()
                                    .contains(filter.toLowerCase())
                                ? ListTile(
                                    onTap: () {
                                      selectedIndexNotifier.value = index;
                                      bottomSheetData = widget.dataList[index];
                                    },
                                    key: Key(index.toString()),
                                    title: Row(
                                      children: [
                                        SizedBox(
                                          width: 5,
                                        ),
                                        value == index
                                            ? Flexible(
                                                child: Text(
                                                  widget.dataList[index]
                                                      .description,
                                                  style: TextStyle(
                                                    color: AppColors
                                                        .textColorMaroon,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              )
                                            : Flexible(
                                                child: Text(
                                                  widget.dataList[index]
                                                      .description,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                        SizedBox(
                                          width: 12,
                                        ),
                                        value == index
                                            ? SvgPicture.asset(
                                                AppImages.icRightMark,
                                                width: 16,
                                                height: 12,
                                              )
                                            : SizedBox(),
                                      ],
                                    ),
                                  )
                                : Container();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
