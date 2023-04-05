import 'package:ceylife_digital/error/messages.dart';
import 'package:flutter/material.dart';

final kSearchTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_BRANCH_LOCATOR_SEARCH, ''),
  border: InputBorder.none,
);

const kCardContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.deepOrange, width: 2.0),
  ),
);
