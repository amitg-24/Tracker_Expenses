import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_expenses/providers/expenses_provider.dart';
import 'package:tracker_expenses/widget/expense_item.dart';

class ExpensesList extends ConsumerWidget {
  const ExpensesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenses = ref.watch(expensesProvider);

    if (expenses.isEmpty) {
      return const Center(child: Text('No expenses found. Start adding some!'));
    }

    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) {
        final expense = expenses[index];
        return Dismissible(
          key: ValueKey(expense),
          background: Container(
            color: Theme.of(context).colorScheme.error.withOpacity(0.5),
            margin: EdgeInsets.symmetric(
              horizontal: Theme.of(context).cardTheme.margin?.horizontal ?? 8,
              vertical: Theme.of(context).cardTheme.margin?.vertical ?? 4,
            ),
          ),
          onDismissed: (direction) {
            final expenseIndex = expenses.indexOf(expense);
            ref.read(expensesProvider.notifier).removeExpense(expense);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Expense deleted'),
                duration: const Duration(seconds: 3),
                action: SnackBarAction(
                  label: 'Undo',
                  onPressed: () {
                    ref
                        .read(expensesProvider.notifier)
                        .undoRemoveExpense(expense, expenseIndex);
                  },
                ),
              ),
            );
          },
          child: ExpenseItem(expense),
        );
      },
    );
  }
}
