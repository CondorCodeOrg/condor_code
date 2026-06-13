import 'package:condor_code/ui/base/bloc/mixin/data_result_processor_mixin.dart';
import 'package:condor_code/ui/base/bloc/mixin/stream_listener_mixin.dart';
import 'package:condor_code/ui/base/provider/events/snack_bar_events_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaseBloc<Event, State> extends Bloc<Event, State>
    with StreamListenerMixin, BaseBlocMixin {
  @override
  final SnackBarEventsProvider snackBarEventsProvider;

  BaseBloc(super.initialState, {required this.snackBarEventsProvider});
}
