import '../models/room_model.dart';

final List<RoomModel> dummyRooms = [
  const RoomModel(
    id: 'r1',
    name: 'Classroom A',
    location: 'Building Alpha - Floor 1',
    description: 'Main smart classroom for IoT practical sessions.',
  ),
  const RoomModel(
    id: 'r2',
    name: 'Embedded Lab',
    location: 'Building Beta - Floor 2',
    description: 'Laboratory for embedded system and ESP32 experiments.',
  ),
  const RoomModel(
    id: 'r3',
    name: 'Lecture Hall',
    location: 'Building Gamma - Floor 3',
    description: 'Large lecture room with monitoring devices.',
  ),
];