import 'package:flutter/material.dart';
import 'dart:math';
import '../models/iot_device_model.dart';
import '../models/enums.dart';

class AddDeviceScreen extends StatefulWidget {
  const AddDeviceScreen({super.key});

  @override
  State<AddDeviceScreen> createState() => _AddDeviceScreenState();
}

class _AddDeviceScreenState extends State<AddDeviceScreen> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = '';
  var _selectedType = DeviceType.smartLamp;

  void _saveDevice() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      
      // Membuat objek model baru
      final newDevice = IoTDeviceModel(
        id: Random().nextInt(1000).toString(), // ID unik sederhana
        name: _enteredName,
        type: _selectedType,
        roomId: 'r1', // Default room
        isOn: false,
        isOnline: true,
        status: DeviceStatus.normal,
        lastUpdated: DateTime.now(),
      );

      Navigator.of(context).pop(newDevice);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Device')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Device Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter a name';
                  return null;
                },
                onSaved: (value) => _enteredName = value!,
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<DeviceType>(
                value: _selectedType,
                items: DeviceType.values.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type.name),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _selectedType = value!),
                decoration: const InputDecoration(labelText: 'Device Type'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveDevice,
                child: const Text('Add Device'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}