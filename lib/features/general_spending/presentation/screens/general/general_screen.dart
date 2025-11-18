import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/transactions/transactions_bloc.dart';
import '../../../../../core/di/service_locator.dart';
import '../screens.dart';
import 'widgets/general_tap.dart';

class GeneralScreen extends StatelessWidget {
  const GeneralScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<TransactionsBloc>()..add(const TransactionsFetchRequested()),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('General'),
            centerTitle: true,
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: GeneralTapBar(),
            ),
          ),
          body: const TabBarView(
            children: [
              SpentScreen(),
              IncomeScreen(),
              //RecordScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
