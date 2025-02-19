part of 'splash_bloc.dart';

@immutable
sealed class SplashStateAbstract {}

class SplashInitial extends SplashStateAbstract {}

class SplashLoading extends SplashStateAbstract {
  final int timerPercentage;
  SplashLoading({required this.timerPercentage});
}

class SplashComplete extends SplashStateAbstract {}

class SplashNavigate extends SplashStateAbstract {}