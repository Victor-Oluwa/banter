import 'package:banter/src/auth_manager/domain/entity/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    super.password,
    super.folderIds,
    super.noteIds
  });

  UserModel.fromEntity(UserEntity user) :this(
    id: user.id,
    name: user.name,
    email: user.email,
    password: user.password,
    folderIds: user.folderIds,
    noteIds: user.noteIds,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  List<dynamic> get props =>
      [
        name,
        email,
        password,
        noteIds,
        folderIds,
      ];
}
