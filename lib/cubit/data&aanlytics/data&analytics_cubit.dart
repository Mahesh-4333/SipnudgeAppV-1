import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp1/cubit/data&aanlytics/data&analytics_state.dart';

class DataAndanalyticsCubit extends Cubit<DataAndAnalyticsInitial> {
  DataAndanalyticsCubit() : super(AnalyticsInitial());
}
