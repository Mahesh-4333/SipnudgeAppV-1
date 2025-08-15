import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp1/cubit/reminder_mode_state.dart';

class ReminderCubit extends Cubit<ReminderState> {
  ReminderCubit()
    : super(const ReminderState(aiReminder: false, steadySipReminder: true));

  void toggleAiReminder(bool value) {
    emit(state.copyWith(aiReminder: value, steadySipReminder: !value));
  }

  void toggleSteadySipReminder(bool value) {
    emit(state.copyWith(steadySipReminder: value));
  }
}
