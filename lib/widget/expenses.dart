import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_expenses/providers/expenses_provider.dart';
import 'package:tracker_expenses/widget/expenses_list.dart';
import 'package:tracker_expenses/widget/new_expense.dart';
import 'package:tracker_expenses/widget/chart/chart.dart';

class Expenses extends ConsumerWidget {
  const Expenses({super.key});

  void _openAddExpenseOverlay(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => const NewExpense(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenses = ref.watch(expensesProvider);
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expense Tracker'),
        actions: [
          IconButton(
            onPressed: () => _openAddExpenseOverlay(context, ref),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: expenses),
                Expanded(child: const ExpensesList()),
              ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expenses: expenses)),
                const Expanded(child: ExpensesList()),
              ],
            ),
    );
  }
}
