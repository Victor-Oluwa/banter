import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class UserEntity extends Equatable {

  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String email;
  final String? password;
  final List<String>? noteIds;
  final List<String>? folderIds;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    this.password,
    this.noteIds,
    this.folderIds,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) => _$UserEntityFromJson(json);
  Map<String, dynamic> toJson() => _$UserEntityToJson(this);

  @override
  List<dynamic> get props => [
        name,
        email,
        password,
        noteIds,
        folderIds,
      ];
}
