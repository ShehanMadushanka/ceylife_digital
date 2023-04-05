import 'dart:convert';
import 'dart:io';

import 'package:ceylife_digital/core/service/app_permission.dart';
import 'package:ceylife_digital/features/domain/entities/response/customer_initiated_category_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/get_csr_main_category_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/policy_details_response_entity.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_dropdown.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_icons_icons.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_outline_button.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_primary_button.dart';
import 'package:ceylife_digital/features/presentation/views/common/common_item_picker.dart';
import 'package:ceylife_digital/features/presentation/views/common/data/bottom_sheet_data.dart';
import 'package:ceylife_digital/features/presentation/views/customer_service_request/data/attachment_data.dart';
import 'package:ceylife_digital/features/presentation/views/customer_service_request/data/csr_args.dart';
import 'package:ceylife_digital/features/presentation/views/customer_service_request/widgets/attachment_item.dart';
import 'package:ceylife_digital/features/presentation/views/user_profile/widgets/advice.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_constants.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:ceylife_digital/utils/validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class CSRNewRequestView extends StatefulWidget {
  final List<ServiceRequestCategoryEntity> serviceRequestCategoriesEntity;
  final List<PolicyDetailItemEntity> policyDetailsList;
  final List<ServiceRequestMainCategoryEntity>
      serviceRequestMainCategoriesEntity;
  final Function(CSRArgs) onSubmit;
  final Function(int) onTapMainCategory;
  final Function(String) onError;
  final VoidCallback shouldContactAdministration;
  final Function(String) validateCharacterCallback;

  CSRNewRequestView(
      {Key key,
      this.onSubmit,
      this.policyDetailsList,
      this.serviceRequestCategoriesEntity,
      this.onTapMainCategory,
      this.onError,
      this.shouldContactAdministration,
      this.validateCharacterCallback,
      this.serviceRequestMainCategoriesEntity})
      : super(key: key);

  @override
  _CSRNewRequestViewState createState() => _CSRNewRequestViewState();
}

class _CSRNewRequestViewState extends State<CSRNewRequestView> {
  Directory rootPath;
  BottomSheetData _selectedPolicy;
  BottomSheetData _selectedData;
  BottomSheetData _selectedMainCategoryData;
  bool fileUploadAvailable = false;
  bool contactAdministrationRequired = false;
  ButtonType _attachmentType = ButtonType.ENABLED;
  List<AttachmentData> files = List();

  final TextEditingController _requestDescriptionController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    initDirectoryData();
  }

  initDirectoryData() async {
    rootPath = await getExternalStorageDirectory();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
                minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 29),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)
                              .translate('label_crm_policy_no'),
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: AppColors.textColorMaroon,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        CeylifeDropdownView(
                          value: _selectedPolicy != null
                              ? _selectedPolicy.description
                              : '',
                          hint: AppLocalizations.of(context)
                              .translate('label_dropdown_select'),
                          onTap: () => widget.policyDetailsList.isNotEmpty
                              ? AppDataPicker(
                                  title: AppLocalizations.of(context)
                                      .translate('label_crm_policy_no'),
                                  defaultSelectedItem: _selectedPolicy,
                                  dataList: widget.policyDetailsList
                                      .map((e) => BottomSheetData(
                                          id: int.parse(e.policyNo),
                                          description: e.policyNo))
                                      .toList(),
                                  onSelectItem: (item) {
                                    setState(() {
                                      _selectedPolicy = item;
                                    });
                                  }).showPicker(context)
                              : null,
                        ),
                        SizedBox(
                          height: 23,
                        ),
                        Text(
                          AppLocalizations.of(context)
                              .translate('label_crm_request_type'),
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: AppColors.textColorMaroon,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        CeylifeDropdownView(
                          value: _selectedMainCategoryData != null
                              ? _selectedMainCategoryData.description
                              : '',
                          hint: AppLocalizations.of(context)
                              .translate('label_dropdown_select'),
                          onTap: () => widget
                                  .serviceRequestMainCategoriesEntity.isNotEmpty
                              ? AppDataPicker(
                                  title: AppLocalizations.of(context)
                                      .translate('label_crm_request_type'),
                                  defaultSelectedItem:
                                      _selectedMainCategoryData,
                                  dataList: widget
                                      .serviceRequestMainCategoriesEntity
                                      .map((e) => BottomSheetData(
                                          id: e.serviceRequestMainCategoryId,
                                          description: e.mainCategory))
                                      .toList(),
                                  onSelectItem: (item) {
                                    setState(() {
                                      _selectedMainCategoryData = item;
                                      _selectedData = null;
                                      widget.serviceRequestCategoriesEntity
                                          .clear();
                                    });
                                    widget.onTapMainCategory(item.id);
                                  }).showPicker(context)
                              : null,
                        ),
                        SizedBox(
                          height: 23,
                        ),
                        Text(
                          AppLocalizations.of(context)
                              .translate("customer_service_request_reason"),
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: AppColors.textColorMaroon,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        CeylifeDropdownView(
                          value: _selectedData != null
                              ? _selectedData.description
                              : '',
                          hint: AppLocalizations.of(context)
                              .translate("label_dropdown_select"),
                          onTap: () => widget
                                  .serviceRequestCategoriesEntity.isNotEmpty
                              ? AppDataPicker(
                                  title: AppLocalizations.of(context).translate(
                                      "customer_service_request_reason"),
                                  defaultSelectedItem: _selectedData,
                                  dataList: widget
                                      .serviceRequestCategoriesEntity
                                      .map((e) => BottomSheetData(
                                          id: e.serviceRequestCategoryId,
                                          description: e.description))
                                      .toList(),
                                  onSelectItem: (item) {
                                    setState(() {
                                      _selectedData = item;
                                      fileUploadAvailable = widget
                                          .serviceRequestCategoriesEntity
                                          .where((element) =>
                                              element
                                                  .serviceRequestCategoryId ==
                                              item.id)
                                          .first
                                          .fileUploadRequired;

                                      contactAdministrationRequired = widget
                                          .serviceRequestCategoriesEntity
                                          .where((element) =>
                                              element
                                                  .serviceRequestCategoryId ==
                                              item.id)
                                          .first
                                          .contactAdministrationRequired;
                                      files.clear();
                                    });
                                  }).showPicker(context)
                              : null,
                        ),
                        fileUploadAvailable
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 28,
                                  ),
                                  Divider(
                                    height: 1,
                                    color: AppColors.dividerColor,
                                    thickness: 1,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)
                                        .translate("label_crm_attachments"),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.textColorMaroon,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    children: [
                                      CeylifeOutlineButton(
                                        buttonType: _attachmentType,
                                        leading: CeylifeIcons.ic_attachment,
                                        text: AppLocalizations.of(context)
                                            .translate("label_crm_add_files"),
                                        onTap: () async {
                                          AppPermissionManager
                                              .requestExternalStoragePermission(
                                                  context, () async {
                                            FilePickerResult result =
                                                await FilePicker.platform
                                                    .pickFiles(
                                              type: FileType.custom,
                                              allowedExtensions: [
                                                'jpg',
                                                'bmp',
                                                'jpeg',
                                                'pdf',
                                                'doc',
                                                'txt',
                                                'docx',
                                                'odt'
                                              ],
                                            );

                                            if (result != null) {
                                              PlatformFile file =
                                                  result.files.first;
                                              if (file.size <=
                                                  UPLOAD_FILE_SIZE_IN_MB) {
                                                setState(() {
                                                  files.add(
                                                    AttachmentData(
                                                      filePath: file.path,
                                                      fileName: file.name,
                                                      extension: file.extension,
                                                      base64File: base64Encode(
                                                        File(file.path)
                                                            .readAsBytesSync(),
                                                      ),
                                                    ),
                                                  );
                                                  if (files.length >= 5) {
                                                    _attachmentType =
                                                        ButtonType.DISABLED;
                                                  } else
                                                    _attachmentType =
                                                        ButtonType.ENABLED;
                                                });
                                              } else {
                                                widget.onError(AppLocalizations
                                                        .of(context)
                                                    .translate(
                                                        'label_crm_advice_file_limit'));
                                              }
                                            }
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 22,
                                  ),
                                  Column(
                                    children: files
                                        .map<AttachmentItemUI>((item) =>
                                            AttachmentItemUI(
                                              data: item,
                                              onRemove: () {
                                                setState(() {
                                                  files.remove(item);

                                                  if (files.length >= 5) {
                                                    _attachmentType =
                                                        ButtonType.DISABLED;
                                                  } else
                                                    _attachmentType =
                                                        ButtonType.ENABLED;
                                                });
                                              },
                                              onTapItem: () {
                                                OpenFile.open(item.filePath);
                                              },
                                            ))
                                        .toList(),
                                  ),
                                  files.length >= 5
                                      ? Column(
                                          children: [
                                            AdviceWidget(
                                              advice: AppLocalizations.of(
                                                      context)
                                                  .translate(
                                                      'label_crm_advice_file_limit'),
                                            ),
                                            SizedBox(
                                              height: 22,
                                            ),
                                          ],
                                        )
                                      : SizedBox.shrink(),
                                  Divider(
                                    height: 1,
                                    color: AppColors.dividerColor,
                                    thickness: 1,
                                  ),
                                ],
                              )
                            : SizedBox.shrink(),
                        SizedBox(
                          height: 23,
                        ),
                        Text(
                          AppLocalizations.of(context).translate(
                              "customer_service_request_request_description"),
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: AppColors.textColorMaroon,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: TextFormField(
                            minLines: 8,
                            maxLines: 15,
                            maxLength: 300,
                            inputFormatters: [
                              new LengthLimitingTextInputFormatter(300),
                            ],
                            textAlign: TextAlign.start,
                            controller: _requestDescriptionController,
                            keyboardType: TextInputType.multiline,
                            cursorColor: AppColors.appHighlightColor,
                            style: TextStyle(
                              color: AppColors.primaryAshColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: InputDecoration(
                              focusColor: Colors.white,
                              hoverColor: Colors.white,
                              counterText: "",
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 8),
                              hintText: AppLocalizations.of(context)
                                  .translate("hint_new_customer_request_desc"),
                              fillColor: Colors.white,
                              hintStyle: TextStyle(
                                  color: AppColors.textColorAsh,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: AppColors.primaryBackgroundColor,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: AppColors.primaryBackgroundColor,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: AppColors.primaryBackgroundColor,
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: AppColors.primaryBackgroundColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 29),
                    child: CeylifePrimaryButton(
                      buttonLabel: AppLocalizations.of(context)
                          .translate('submit_request_button'),
                      width: double.infinity,
                      buttonType: (_selectedData != null &&
                              _selectedPolicy != null &&
                              (fileUploadAvailable ? (files.isNotEmpty) : true))
                          ? ButtonType.ENABLED
                          : ButtonType.DISABLED,
                      onTap: () async {
                        if (contactAdministrationRequired != null &&
                            contactAdministrationRequired)
                          widget.shouldContactAdministration();
                        else {
                          if(_requestDescriptionController.text.isNotEmpty) {
                            if (Validator.validateEnglishCharacters(
                                _requestDescriptionController.text.trim())) {
                              widget.onSubmit(
                                CSRArgs(
                                    serviceRequestCategoryId: _selectedData.id,
                                    comment: _requestDescriptionController.text,
                                    serviceRequestMainCategoryId:
                                    _selectedMainCategoryData.id,
                                    policyNo: _selectedPolicy.description,
                                    fileList: files.toList()),
                              );
                            } else {
                              widget.validateCharacterCallback(AppLocalizations.of(context)
                                  .translate('csr_character_validation_desc'));
                            }
                          }else{
                            widget.validateCharacterCallback(AppLocalizations.of(context)
                                .translate('csr_desc_error'));
                          }
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 48,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
