import 'package:flutter/material.dart';

class AddressPage extends StatefulWidget {
  final Function(Map<String, dynamic>) onAddressSaved;

  const AddressPage({
    Key? key,
    required this.onAddressSaved,
  }) : super(key: key);

  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Address'),
        backgroundColor: Color.fromARGB(255, 107, 100, 237),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _addressController,
              decoration: InputDecoration(
                labelText: 'Enter Address',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  String address = _addressController.text.trim();
                  if (address.isNotEmpty) {
                    widget.onAddressSaved({
                      'address': address,
                    });
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 107, 100, 237),
                  padding:
                      EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
                  textStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                child: Text(
                  'Save Address',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }
}
