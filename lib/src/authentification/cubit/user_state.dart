part of 'user_cubit.dart';

@immutable
class UserState {
  final UserModel? user;

  const UserState({
    this.user,
  });

  UserState copyWith({
    UserModel? user,
  }) {
    return UserState(
      user: user ?? this.user,
    );
  }
}

class UserInitial extends UserState {}
