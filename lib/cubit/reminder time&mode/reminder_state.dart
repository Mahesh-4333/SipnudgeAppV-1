import 'package:flutterapp1/reminder_interval.dart';

class ReminderIntervalState {
  final ReminderInterval interval;
  // map "HH:mm" -> enabled
  final Map<String, bool> slots;

  const ReminderIntervalState({required this.interval, required this.slots});

  ReminderIntervalState copyWith({
    ReminderInterval? interval,
    Map<String, bool>? slots,
  }) {
    return ReminderIntervalState(
      interval: interval ?? this.interval,
      slots: slots ?? this.slots,
    );
  }
}
