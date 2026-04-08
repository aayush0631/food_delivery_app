import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:week8/models/add_to_cart.dart';

class AddToCartSheet extends StatelessWidget {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;

  AddToCartSheet({
    Key? key,
    this.completer,
    required this.request,
  }) : super(key: key);

  final TextEditingController qtyController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Add to Cart"),
          TextField(
            controller: qtyController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: "Quantity"),
          ),
          TextField(
            controller: noteController,
            decoration: InputDecoration(labelText: "Note (optional)"),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              completer!(
                SheetResponse(
                  confirmed: true,
                  data: AddToCartSheetData(
                    quantity: int.tryParse(qtyController.text) ?? 1,
                    note: noteController.text,
                  ),
                ),
              );
            },
            child: const Text("Add"),
          )
        ],
      ),
    );
  }
}
