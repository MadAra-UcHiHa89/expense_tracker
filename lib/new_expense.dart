import "package:flutter/material.dart";

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  @override
  Widget build(context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            maxLength: 50,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: "Title",
            ),
          )
        ],
      ),
    );
  }
}