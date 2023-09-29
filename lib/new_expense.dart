import "package:flutter/material.dart";
import "package:expense_tracker/models/expense.dart";

class NewExpense extends StatefulWidget {
  NewExpense({super.key, required this.onAddExpense});

  void Function(Expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.food;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _saveExpense() {
    final amount = double.tryParse(_amountController
        .text); // return null if string cannot be parsed to double
    bool amountIsInvalid = amount == null || amount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      // show error message
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(
            "Invalid input",
          ),
          content: Text(
            "Please enter valid input",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // context of the AlertDialog
              },
              child: Text(
                "Go back",
              ),
            )
          ],
        ),
      );
      return;
    }
    // => alll input valid , create a new expense
    final newExpense = Expense(
        title: _titleController.text.trim(),
        amount: amount,
        date: _selectedDate!,
        category: _selectedCategory);
    widget
        .onAddExpense(newExpense); // pass the new expense to the parent widget
    // now close the modal bottom sheet
    Navigator.pop(context);
  }

  void _showDatePicker() async {
    final now = DateTime.now();
    // opens up a date picker dialog
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: DateTime(now.year - 1, now.month, now.day),
        lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              labelText: "Title",
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixText: "\$ ",
                    label: Text(
                      "Amount",
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Row(
                children: [
                  Text(
                    _selectedDate == null
                        ? "No Date Selected"
                        : formatter.format(_selectedDate!),
                  ),
                  IconButton(
                    onPressed: _showDatePicker,
                    icon: const Icon(
                      Icons.calendar_month,
                    ),
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: Category.values
                    .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(
                            category.name.toUpperCase(),
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
              const Spacer(),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel"),
                  ),
                  // const SizedBox(
                  //   width: 20,
                  // ),
                  ElevatedButton(
                    onPressed: _saveExpense,
                    child: const Text(
                      "Save expense",
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
