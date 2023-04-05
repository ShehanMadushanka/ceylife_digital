import 'package:equatable/equatable.dart';

class FAQ extends Equatable {
  String question;
  String answer;
  String link;
  int linkReference;
  int sortedKey;

  FAQ(this.question, this.answer, this.link, this.linkReference, this.sortedKey);

  @override
  List<Object> get props => [question, answer, link, linkReference];
}

class FAQResponseEntity extends Equatable {
  String responseCode;
  String responseError;
  List<FAQ> faqData;

  FAQResponseEntity({this.responseCode, this.responseError, this.faqData});

  @override
  List<Object> get props => [responseCode, responseError, faqData];
}
