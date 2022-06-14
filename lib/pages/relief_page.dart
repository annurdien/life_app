import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ReliefPage extends StatefulHookConsumerWidget {
  const ReliefPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReliefPageState();
}

class _ReliefPageState extends ConsumerState<ReliefPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Relief"),
      ),
    );
  }
}
