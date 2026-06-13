import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//TODO: (WeakDroid) Implement error page UI and functionality
class ErrorPage extends ConsumerStatefulWidget {
  const ErrorPage({super.key});

  @override
  ConsumerState createState() => _ErrorPageState();
}

class _ErrorPageState extends ConsumerState<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
