import 'package:condor_code/di/provider_manager.dart';
import 'package:condor_code/ui/base/provider/events/snack_bar_events_provider.dart';
import 'package:condor_code/ui/screens/main/bloc/snack_bar_cubit.dart';
import 'package:condor_code/ui/utils/snack_bar_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SnackBarProducerWidget extends StatelessWidget {
  final Widget child;

  const SnackBarProducerWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => di<SnackBarCubit>(),
    child: BlocListener<SnackBarCubit, SnackBarEvent?>(
      listener: (context, event) {
        if (event != null) {
          SnackBarUtil.showSnackBar(context, event);
        }
      },
      child: child,
    ),
  );
}
