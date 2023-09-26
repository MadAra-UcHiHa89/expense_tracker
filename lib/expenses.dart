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

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => NewExpense(),
    );
  }

  @override
  Widget build(context) {
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
      body: Column(children: [
        const Text(
          "Chart",
        ),
        Expanded(
          child: ExpensesList(
            expenses: _registeredExpenses,
          ),
        )
      ]),
    );
  }
}
