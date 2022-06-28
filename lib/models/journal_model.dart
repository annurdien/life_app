import 'package:freezed_annotation/freezed_annotation.dart';

part 'journal_model.freezed.dart';
part 'journal_model.g.dart';

@freezed
class JournalModel with _$JournalModel {
  const factory JournalModel({
    required String title,
    required String body,
    required int feeling,
    required List<String> emotion,
    required DateTime created_at,
  }) = _JournalModel;

  factory JournalModel.fromJson(Map<String, dynamic> json) =>
      _$JournalModelFromJson(json);
}

@freezed
class JournalDto with _$JournalDto {
  const factory JournalDto({
    required String title,
    required String body,
    required int feeling,
    required List<String> emotion,
  }) = _JournalDto;

  factory JournalDto.fromJson(Map<String, dynamic> json) =>
      _$JournalDtoFromJson(json);
}
