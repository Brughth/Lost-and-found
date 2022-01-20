part of 'user_cubit.dart';

@immutable
class UserInitial extends UserState {}

class UserState {
  final bool isLogingIn;
  final bool successLogingIn;
  final bool errorLogingIn;
  final UserModel? user;
  final bool isCheckingAuthState;
  final bool isAuthenticated;
  final String? error;

  const UserState({
    this.isLogingIn = false,
    this.successLogingIn = false,
    this.errorLogingIn = false,
    this.error,
    this.user,
    this.isCheckingAuthState = false,
    this.isAuthenticated = false,
  });

  UserState copyWith({
    bool? isLogingIn,
    bool? successLogingIn,
    bool? errorLogingIn,
    UserModel? user,
    String? error,
    bool? isCheckingAuthState,
    bool? isAuthenticated,
  }) {
    return UserState(
      error: error ?? this.error,
      isLogingIn: isLogingIn ?? this.isLogingIn,
      successLogingIn: successLogingIn ?? this.successLogingIn,
      errorLogingIn: errorLogingIn ?? this.errorLogingIn,
      user: user ?? this.user,
      isCheckingAuthState: isCheckingAuthState ?? this.isCheckingAuthState,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }
}
