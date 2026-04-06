import '../models/enums.dart';
import '../models/iot_device_model.dart';

final List<IoTDeviceModel> initialDummyDevices = [
  IoTDeviceModel(
    id: 'd3',
    name: 'Temperature Sensor 01',
    type: DeviceType.temperatureSensor,
    roomId: 'r2',
    isOn: true,
    isOnline: true,
    status: DeviceStatus.normal,
    temperature: 24.6,
    humidity: 58.2,
    lastUpdated: DateTime.now(),
  ),
];