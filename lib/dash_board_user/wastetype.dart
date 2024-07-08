import 'package:flutter/material.dart';

class WasteTypeTile extends StatelessWidget {
  final Map<String, dynamic> wasteType;
  final VoidCallback onRemove;

  const WasteTypeTile(
      {required this.wasteType, required this.onRemove, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ListTile(
          title: Text(wasteType['name']),
          subtitle: Text('Amount: ${wasteType['amount']}'),
          trailing: IconButton(
            icon: const Icon(Icons.remove_circle_outline),
            onPressed: onRemove,
          ),
        ),
      ),
    );
  }
}
