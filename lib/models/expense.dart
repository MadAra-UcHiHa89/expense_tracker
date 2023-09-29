import "package:uuid/uuid.dart";
import "package:flutter/material.dart";
import "package:intl/intl.dart";

final formatter = DateFormat.yMd();

const uuid = Uuid(); // create a Uuid instance

enum Category { food, travel, leisure, work }

// create a Map that maps each category to an icon
const categoryIcons = {
  Category.food: Icons.lunch_dining_outlined,
  Category.travel: Icons.flight,
  Category.leisure: Icons.sports_esports_outlined,
  Category.work: Icons.work_history_outlined,
};

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  // getter for formatted date
  String get formattedDate {
    return "${date.day}/${date.month}/${date.year}";
  }
}

class ExpenseBucket {
  ExpenseBucket({required this.category, required this.expenses});

  // Constuctor which filters out the expenses that don't belong to the category
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalAmount {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
