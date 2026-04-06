import 'package:flutter/material.dart';
import '../models/iot_device_model.dart';
import '../models/enums.dart';
import '../data/dummy_devices.dart';
import 'add_device_screen.dart'; // Pastikan file ini dibuat

class DeviceListScreen extends StatefulWidget {
  const DeviceListScreen({super.key});

  @override
  State<DeviceListScreen> createState() => _DeviceListScreenState();
}

class _DeviceListScreenState extends State<DeviceListScreen> {
  // Menggunakan data awal dari dummy_devices.dart
  final List<IoTDeviceModel> _devices = [...initialDummyDevices];

  void _addNewDevice(IoTDeviceModel newDevice) {
    setState(() {
      _devices.add(newDevice);
    });
  }

  void _removeDevice(int index) {
    final removedDevice = _devices[index];
    final originalIndex = index;

    setState(() {
      _devices.removeAt(index);
    });

    // Fitur Undo menggunakan SnackBar
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${removedDevice.name} dihapus'),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            setState(() {
              // Mengembalikan ke index yang spesifik agar urutan tetap sama
              _devices.insert(originalIndex, removedDevice);
            });
          },
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My IoT Devices'),
      ),
      body: _devices.isEmpty
          ? const Center(child: Text('Tidak ada perangkat.'))
          : ListView.builder(
              itemCount: _devices.length,
              itemBuilder: (ctx, index) {
                final device = _devices[index];
                
                // Keyword: Dismissible untuk fitur swipe
                return Dismissible(
                  key: ValueKey(device.id), // Menggunakan ID unik agar index tidak tertukar
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    _removeDevice(index);
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    child: ListTile(
                      leading: Icon(_getDeviceIcon(device.type)),
                      title: Text(device.name),
                      subtitle: Text('Status: ${device.status.name}'),
                      trailing: Switch(
                        value: device.isOn,
                        onChanged: (val) {
                          setState(() {
                            device.isOn = val;
                          });
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navigasi ke halaman Add Device
          final result = await Navigator.of(context).push<IoTDeviceModel>(
            MaterialPageRoute(builder: (ctx) => const AddDeviceScreen()),
          );

          if (result != null) {
            _addNewDevice(result);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  IconData _getDeviceIcon(DeviceType type) {
    switch (type) {
      case DeviceType.smartLamp: return Icons.lightbulb;
      case DeviceType.smartFan: return Icons.cyclone;
      case DeviceType.smartPlug: return Icons.power;
      case DeviceType.temperatureSensor: return Icons.thermostat;
      case DeviceType.humiditySensor: return Icons.water_drop;
    }
  }
}