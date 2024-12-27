import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'sample_data.dart';

void main() => runApp(DriverMovementApp());

class DriverMovementApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Driver Movement Visualizer',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MovementMapPage(),
    );
  }
}

class MovementMapPage extends StatefulWidget {
  @override
  _MovementMapPageState createState() => _MovementMapPageState();
}

class _MovementMapPageState extends State<MovementMapPage> {
  String? filter;

  @override
  Widget build(BuildContext context) {
    List<Movement> filteredMovements = filter == null
        ? sampleMovements
        : sampleMovements.where((m) => m.status == filter).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Driver Movement Visualizer'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                filter = value == 'All' ? null : value.toLowerCase();
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 'All', child: Text('All')),
              PopupMenuItem(value: 'Break', child: Text('Break')),
              PopupMenuItem(value: 'Ride', child: Text('Ride')),
              PopupMenuItem(value: 'Other', child: Text('Other')),
            ],
          ),
        ],
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(37.7749, -122.4194),
          zoom: 13,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          PolylineLayer(
            polylines: [
              Polyline(
                points: filteredMovements.map((m) => m.location).toList(),
                color: Colors.blue,
                strokeWidth: 3,
              ),
            ],
          ),
          MarkerLayer(
            markers: filteredMovements.map((movement) {
              Color markerColor;
              switch (movement.status) {
                case 'break':
                  markerColor = Colors.red;
                  break;
                case 'ride':
                  markerColor = Colors.green;
                  break;
                case 'other':
                  markerColor = Colors.yellow;
                  break;
                default:
                  markerColor = Colors.blue;
              }
              return Marker(
                width: 80.0,
                height: 80.0,
                point: movement.location,
                builder: (ctx) => Icon(Icons.location_on, color: markerColor, size: 30),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
