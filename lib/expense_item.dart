import "package:flutter/material.dart";
import "package:expense_tracker/models/expense.dart";

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({super.key, required this.expense});

  final Expense expense;

  @override
  Widget build(context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Column(
          children: [
            Text(
              expense.title,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "\$${expense.amount.toStringAsFixed(2)}",
                ),
                const Spacer(), // takes up all the available space between the two widgets in the row
                Row(
                  children: [
                    Icon(
                      categoryIcons[expense.category],
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      expense.formattedDate,
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
