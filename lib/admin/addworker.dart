import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddWorkerPage extends StatefulWidget {
  @override
  _AddWorkerPageState createState() => _AddWorkerPageState();
}

class _AddWorkerPageState extends State<AddWorkerPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _phone = '';
  String _address = '';
  bool _isWorker = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Worker Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                onSaved: (value) => _name = value!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                onSaved: (value) => _email = value!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an email';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone'),
                onSaved: (value) => _phone = value!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Address'),
                onSaved: (value) => _address = value!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an address';
                  }
                  return null;
                },
              ),
              SwitchListTile(
                title: Text('Is Worker'),
                value: _isWorker,
                onChanged: (bool value) {
                  setState(() {
                    _isWorker = value;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      FirebaseFirestore.instance.collection('users').add({
        'name': _name,
        'email': _email,
        'phone': _phone,
        'address': _address,
        'isWorker': _isWorker,
      }).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User added successfully!')),
        );
        _formKey.currentState!.reset();
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add user: $error')),
        );
      });
    }
  }
}
