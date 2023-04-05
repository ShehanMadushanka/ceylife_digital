class BaseAPIHandler {
  String data;
  String keyInfo;

  BaseAPIHandler({this.data, this.keyInfo});

  BaseAPIHandler.fromJson(Map<String, dynamic> json)
      : data = json['data'],
        keyInfo = json['keyInfo'];

  Map<String, dynamic> toJson() => {
    'data': data,
    'keyInfo': keyInfo,
  };
}