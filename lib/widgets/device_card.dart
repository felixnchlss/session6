import 'package:flutter/material.dart';
import '../models/iot_device_model.dart';
import '../models/enums.dart';

class DeviceCard extends StatelessWidget {
  final IoTDeviceModel device;
  final VoidCallback onDismissed;
  final Function(bool) onToggle;

  const DeviceCard({
    super.key,
    required this.device,
    required this.onDismissed,
    required this.onToggle,
  });

  // Helper untuk menentukan icon berdasarkan tipe perangkat
  IconData _getDeviceIcon(DeviceType type) {
    switch (type) {
      case DeviceType.smartLamp:
        return Icons.lightbulb_outline;
      case DeviceType.smartFan:
        return Icons.cyclone;
      case DeviceType.smartPlug:
        return Icons.power_settings_new;
      case DeviceType.temperatureSensor:
        return Icons.thermostat;
      case DeviceType.humiditySensor:
        return Icons.water_drop;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      // Menggunakan ID unik sebagai key agar index tetap sinkron saat didelete
      key: ValueKey(device.id), 
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red.shade700,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) => onDismissed(),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        elevation: 2,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: device.isOnline ? Colors.blue.shade100 : Colors.grey.shade300,
            child: Icon(_getDeviceIcon(device.type), color: Colors.blue),
          ),
          title: Text(
            device.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            'Status: ${device.status.name}${device.temperature != null ? ' | ${device.temperature}°C' : ''}',
          ),
          trailing: Switch(
            value: device.isOn,
            onChanged: onToggle,
          ),
        ),
      ),
    );
  }
}