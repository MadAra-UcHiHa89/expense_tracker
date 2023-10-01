import "package:expense_tracker/chart.dart";
import "package:expense_tracker/expenses_list.dart";
import "package:expense_tracker/new_expense.dart";
import "package:flutter/material.dart";
import "package:expense_tracker/models/expense.dart";

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: "Movies",
      amount: 10,
      date: DateTime(2023),
      category: Category.leisure,
    ),
    Expense(
      title: "Flutter Course",
      amount: 30.99,
      date: DateTime.now(),
      category: Category.work,
    )
  ];

  void _addExpense(Expense newExpense) {
    setState(() {
      _registeredExpenses.add(newExpense);
    });
  }

  void _dismissExpense(Expense expense) {
    final index = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context)
        .clearSnackBars(); // removes all visible snackbars
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(
          seconds: 5,
        ),
        content: Text(
          "Expense Deleted",
        ),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(
              () {
                // add the expense back to the list in the same position
                _registeredExpenses.insert(index, expense);
              },
            );
          },
        ),
      ),
    );
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true, // make the sheet full screen
      context: context,
      builder: (ctx) => NewExpense(
        onAddExpense: _addExpense,
      ),
    );
  }

  @override
  Widget build(context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    Widget _mainContent = Center(
      child: const Text(
        "No expenses added yet",
      ),
    );

    if (_registeredExpenses.length > 0) {
      _mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onDismissItem: _dismissExpense,
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Expense Tracker",
          ),
          actions: [
            IconButton(
              onPressed: _openAddExpenseOverlay,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: width < 620
            ? Column(children: [
                Chart(expenses: _registeredExpenses),
                Expanded(
                  child: _mainContent,
                )
              ])
            : Row(
                children: [
                  Expanded(child: Chart(expenses: _registeredExpenses)),
                  Expanded(
                    child: _mainContent,
                  )
                ],
              ));
  }
}
