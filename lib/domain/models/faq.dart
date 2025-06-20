import 'package:freezed_annotation/freezed_annotation.dart';

part 'faq.freezed.dart';

@freezed
abstract class FAQ with _$FAQ {
  const factory FAQ({required String question, required String answer}) = _FAQ;
}
