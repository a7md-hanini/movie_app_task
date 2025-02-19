import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEventAbstract, SplashStateAbstract> {
  Timer? _timer;
  final int duration = 1000; // Total duration in milliseconds

  SplashBloc() : super(SplashInitial()) {
    on<StartTimerEvent>(_onStartTimer);
  }

  Future<void> _onStartTimer(
      StartTimerEvent event, Emitter<SplashStateAbstract> emit) async {
    int percentage = 0;


    _timer?.cancel();
    emit(SplashLoading(timerPercentage: percentage));

    await Future.forEach(List.generate(100, (index) => index), (int i) async {
      await Future.delayed(Duration(milliseconds: duration ~/ 100));
      percentage = i + 1;
      emit(SplashLoading(timerPercentage: percentage));
    });


    emit(SplashComplete());

    if (!emit.isDone) {
      emit(SplashNavigate());
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
