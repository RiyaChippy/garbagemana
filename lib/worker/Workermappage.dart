import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class WorkerMapPage extends StatefulWidget {
  final LatLng userLocation;

  WorkerMapPage({required this.userLocation});

  @override
  _WorkerMapPageState createState() => _WorkerMapPageState();
}

class _WorkerMapPageState extends State<WorkerMapPage> {
  GoogleMapController? _controller;
  LatLng? _workerLocation;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    _markers.add(Marker(
      markerId: MarkerId('userLocation'),
      position: widget.userLocation,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    ));
  }

  void _selectWorkerLocation(LatLng location) {
    setState(() {
      _workerLocation = location;
      _markers
          .removeWhere((marker) => marker.markerId.value == 'workerLocation');
      _markers.add(Marker(
        markerId: MarkerId('workerLocation'),
        position: location,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ));
    });
    _drawPolyline();
  }

  void _drawPolyline() {
    if (_workerLocation == null) return;

    // Clear existing polylines
    _polylines.clear();

    // Add polyline from userLocation to workerLocation
    _polylines.add(Polyline(
      polylineId: PolylineId('route'),
      color: Colors.blue,
      width: 5,
      points: [
        widget.userLocation,
        _workerLocation!,
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Worker Location'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: _workerLocation == null
                ? null
                : () {
                    Navigator.pop(context, _workerLocation);
                  },
          ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: widget.userLocation,
          zoom: 12,
        ),
        onMapCreated: (controller) {
          setState(() {
            _controller = controller;
          });
        },
        onTap: _selectWorkerLocation,
        markers: _markers,
        polylines: _polylines,
      ),
    );
  }
}
