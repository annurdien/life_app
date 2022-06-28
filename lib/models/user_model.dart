import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  UserModel({
    this.id,
    required this.name,
    required this.email,
    this.phone,
    this.image,
  });

  @HiveField(0)
  late final String? id;
  @HiveField(1)
  late final String name;
  @HiveField(2)
  late final String email;
  @HiveField(3)
  late final String? phone;
  @HiveField(4)
  late final String? image;

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['image'] = image;

    return data;
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? image,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      image: image ?? this.image,
    );
  }
}

@freezed
class UserDto with _$UserDto {
  const factory UserDto({
    required String? email,
    required String? image,
    required String? name,
    required String? phone,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);
}
