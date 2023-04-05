// To parse this JSON data, do
//
//     final keyExchangeRequest = keyExchangeRequestFromJson(jsonString);

import 'package:ceylife_digital/features/data/models/requests/key_exchange_request.dart';

class KeyExchangeRequestEntity extends KeyExchangeRequest {
  KeyExchangeRequestEntity({
    this.key,
  }) : super(key: key);

  String key;
}
