import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:week8/models/add_to_cart.dart';

class AddToCartSheet extends StatefulWidget {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;

  const AddToCartSheet({
    Key? key,
    this.completer,
    required this.request,
  }) : super(key: key);

  @override
  State<AddToCartSheet> createState() => _AddToCartSheetState();
}

class _AddToCartSheetState extends State<AddToCartSheet> {
  final TextEditingController qtyController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  @override
  void dispose() {
    qtyController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Handle bar
          Center(
            child: Container(
              width: 40,
              height: 5,
              margin: const EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const Text(
            "Add to Cart",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: qtyController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Quantity",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: noteController,
            decoration: InputDecoration(
              labelText: "Note (optional)",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                widget.completer!(
                  SheetResponse(
                    confirmed: true,
                    data: AddToCartSheetData(
                      quantity: int.tryParse(qtyController.text) ?? 1,
                      note: noteController.text,
                    ),
                  ),
                );
              },
              child: const Text("Add to Cart"),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}