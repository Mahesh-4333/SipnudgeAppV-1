import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp1/cubit/help&support/help&support_state.dart';

class HelpAndSupportCubit extends Cubit<HelpAndSupportState> {
  HelpAndSupportCubit() : super(const HelpAndSupportState());

  void updateTab(String tab) {
    emit(state.copyWith(activeTab: tab));
  }
}
