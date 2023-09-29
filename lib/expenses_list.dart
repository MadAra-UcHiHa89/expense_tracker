import "package:expense_tracker/expense_item.dart";
import "package:expense_tracker/models/expense.dart";
import "package:flutter/material.dart";

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onDismissItem});

  final void Function(Expense) onDismissItem;

  final List<Expense> expenses;

  @override
  Widget build(context) {
    return ListView.builder(
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(expenses[
            index]), // ValueKey is a generic class that takes a value of any type as a parameter and uses it as the key
        onDismissed: (DismissDirection direction) {
          onDismissItem(expenses[index]);
        },
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.8),
          margin: EdgeInsets.symmetric(
              horizontal: Theme.of(context).cardTheme.margin!.horizontal),
          child: Icon(
            Icons.delete,
            color: Theme.of(context).colorScheme.onError,
            size: 40,
          ),
        ),
        child: ExpenseItem(
          expense: expenses[index],
        ),
      ),
      itemCount: expenses.length,
    );
  }
}
