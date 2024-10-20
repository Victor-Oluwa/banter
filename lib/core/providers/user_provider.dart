import 'package:banter/src/auth_manager/domain/entity/user_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider =
    StateNotifierProvider<UserNotifier, UserEntity>((ref) => UserNotifier());

class UserNotifier extends StateNotifier<UserEntity> {
  UserNotifier()
      : super(const UserEntity(
          id: '',
          name: '',
          email: '',
        ));

  void setUser(UserEntity user){
    state = user;
  }
}
