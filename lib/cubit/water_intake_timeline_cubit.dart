import 'package:flutter_bloc/flutter_bloc.dart';

enum HydrationStatus { completed, pending }

class HydrationEntry {
  final String label;
  final String timeRange;
  final int amount;
  HydrationStatus status;

  HydrationEntry({
    required this.label,
    required this.timeRange,
    required this.amount,
    this.status = HydrationStatus.pending,
  });
}

class HydrationState {
  final List<HydrationEntry> entries;
  final int totalDrank;
  final int goal;
  final DateTime selectedDate;

  HydrationState({
    required this.entries,
    required this.totalDrank,
    required this.goal,
    required this.selectedDate,
  });
  HydrationState copyWith({
    List<HydrationEntry>? entries,
    int? totalDrank,
    int? goal,
    DateTime? selectedDate,
  }) {
    return HydrationState(
      entries: entries ?? this.entries,
      totalDrank: totalDrank ?? this.totalDrank,
      goal: goal ?? this.goal,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}

class HydrationCubit extends Cubit<HydrationState> {
  HydrationCubit()
    : super(
        HydrationState(
          entries: [
            HydrationEntry(
              label: 'Wakeup time',
              timeRange: '7:00–8:00 AM',
              amount: 500,
              status: HydrationStatus.completed,
            ),
            HydrationEntry(
              label: 'Breakfast Time',
              timeRange: '8:30–9:30 AM',
              amount: 250,
              status: HydrationStatus.completed,
            ),
            HydrationEntry(
              label: 'Mid-Morning',
              timeRange: '11:00 AM',
              amount: 250,
              status: HydrationStatus.completed,
            ),
            HydrationEntry(
              label: 'Lunch Time',
              timeRange: '1:00–2:00 PM',
              amount: 250,
            ),
            HydrationEntry(
              label: 'Mid-Afternoon',
              timeRange: '4:00 PM',
              amount: 250,
            ),
            HydrationEntry(
              label: 'Evening',
              timeRange: '6:00–7:00 PM',
              amount: 250,
            ),
            HydrationEntry(
              label: 'After Dinner',
              timeRange: '8:30–9:30 PM',
              amount: 250,
            ),
          ],
          totalDrank: 2000,
          goal: 2400,
          selectedDate: DateTime.now(),
        ),
      );

  void toggleStatus(int index) {
    final updated = List<HydrationEntry>.from(state.entries);
    updated[index].status =
        updated[index].status == HydrationStatus.completed
            ? HydrationStatus.pending
            : HydrationStatus.completed;

    int total = updated
        .where((e) => e.status == HydrationStatus.completed)
        .fold(0, (sum, e) => sum + e.amount);

    emit(
      HydrationState(
        entries: updated,
        totalDrank: total,
        goal: state.goal,
        selectedDate: DateTime.now(),
      ),
    );
  }

  void updateDate(DateTime newDate) {
    emit(state.copyWith(selectedDate: newDate));
  }
}
