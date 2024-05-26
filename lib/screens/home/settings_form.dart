// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:coffee/shared/constants.dart';
import 'package:coffee/services/database.dart';

class SettingsForm extends StatefulWidget {
  final VoidCallback? onSettingsUpdated;

  const SettingsForm({Key? key, this.onSettingsUpdated}) : super(key: key);

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final DatabaseService _dbService = DatabaseService(uid: 'current_user_uid');
  final List<String> sugars = ['0', '1', '2', '3', '4'];
  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Update your brew settings.',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20.0),
          TextFormField(
            initialValue: _currentName ?? '',
            style: const TextStyle(color: Colors.black),
            decoration: textInputDecoration.copyWith(labelText: 'Name'),
            validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
            onChanged: (val) => setState(() => _currentName = val),
          ),
          const SizedBox(height: 20.0),
          DropdownButtonFormField(
            style: const TextStyle(color: Colors.black),
            value: _currentSugars,
            decoration: textInputDecoration.copyWith(
              labelText: 'Sugars',
              suffixIcon: const Icon(Icons.arrow_drop_down),
            ),
            items: sugars.map((sugar) {
              return DropdownMenuItem(
                value: sugar,
                child: Container(
                  color: Colors.white,
                  child: Text('$sugar sugars'),
                ),
              );
            }).toList(),
            validator: (val) => val == null ? 'Please select a sugar level' : null,
            onChanged: (val) => setState(() => _currentSugars = val.toString()),
          ),
          const SizedBox(height: 20.0),
          Slider(
            value: (_currentStrength ?? 100).toDouble(),
            activeColor: Colors.brown[_currentStrength ?? 100],
            inactiveColor: Colors.brown[_currentStrength ?? 100],
            min: 100.0,
            max: 900.0,
            divisions: 8,
            onChanged: (val) => setState(() => _currentStrength = val.round()),
          ),
          const SizedBox(height: 20.0),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await _dbService.updateUserData(
                    _currentSugars ?? '',
                    _currentName ?? '',
                    _currentStrength ?? 100,
                  );
                  widget.onSettingsUpdated?.call();
                }
              },
              child: const Text('Update'),
            ),
          ),
        ],
      ),
    );
  }
}
