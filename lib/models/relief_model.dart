import 'package:freezed_annotation/freezed_annotation.dart';

part 'relief_model.freezed.dart';
part 'relief_model.g.dart';

@freezed
class ReliefModel with _$ReliefModel {
  const factory ReliefModel({
    required String image,
    required String title,
    required String type,
    required String url,
    required int length,
  }) = _ReliefModel;

  factory ReliefModel.fromJson(Map<String, dynamic> json) =>
      _$ReliefModelFromJson(json);
}

@freezed
class ReliefDto with _$ReliefDto {
  const factory ReliefDto({
    required String image,
    required String title,
    required String type,
    required String url,
    required int length,
  }) = _ReliefDto;

  factory ReliefDto.fromJson(Map<String, dynamic> json) =>
      _$ReliefDtoFromJson(json);
}
