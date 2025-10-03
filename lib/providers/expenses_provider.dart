import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_expenses/model/expense.dart';  
  
  class ExpensesNotifier extends StateNotifier<List<Expense>> {
  ExpensesNotifier() : super([
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
  ]);

  void addExpense(Expense expense) {
    state = [...state, expense];
  }

  void removeExpense(Expense expense) {
    state = state.where((e) => e != expense).toList();
  }

  void undoRemoveExpense(Expense expense, int index) {
    final newList = [...state];
    newList.insert(index, expense);
    state = newList;
  }
}

final expensesProvider =
    StateNotifierProvider<ExpensesNotifier, List<Expense>>(
  (ref) => ExpensesNotifier(),
);
