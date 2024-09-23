part of 'splash_bloc.dart';

@immutable
sealed class SplashState {}

sealed class SplashActionState extends SplashState {}

final class SplashInitial extends SplashState {}

final class SplashErrorState extends SplashState {
  final String err;
  SplashErrorState({required this.err});
}

final class SplashLoadingState extends SplashState {}

final class SplashSuccessState extends SplashState {
  final Position position;
  SplashSuccessState(this.position);
}

final class SplashNavigateToState extends SplashActionState {
  final Position position;
  SplashNavigateToState(this.position);
}
