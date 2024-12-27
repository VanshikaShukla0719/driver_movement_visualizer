// sample_data.dart
import 'package:latlong2/latlong.dart';

class Movement {
  final LatLng location;
  final String status;

  Movement({required this.location, required this.status});
}

List<Movement> sampleMovements = [
  Movement(location: LatLng(37.7749, -122.4194), status: 'ride'),
  Movement(location: LatLng(37.7849, -122.4094), status: 'break'),
  Movement(location: LatLng(37.7949, -122.3994), status: 'other'),
];
