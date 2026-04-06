import 'enums.dart';

class IoTDeviceModel {
  final String id;
  String name;
  final DeviceType type;
  final String roomId;
  bool isOn;
  bool isOnline;
  DeviceStatus status;
  double? temperature;
  double? humidity;
  final DateTime lastUpdated;

  IoTDeviceModel({
    required this.id,
    required this.name,
    required this.type,
    required this.roomId,
    required this.isOn,
    required this.isOnline,
    required this.status,
    this.temperature,
    this.humidity,
    required this.lastUpdated,
  });
}