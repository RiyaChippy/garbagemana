import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:garbagemana/worker/Workermappage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'task_model.dart';
// Make sure to import the WorkerMapPage

class TaskDetailsPage extends StatefulWidget {
  final Task task;

  const TaskDetailsPage({Key? key, required this.task}) : super(key: key);

  @override
  _TaskDetailsPageState createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends State<TaskDetailsPage> {
  GoogleMapController? _mapController;
  LatLng _currentLocation = LatLng(0, 0);
  late Marker _taskMarker;
  LatLng? _workerLocation;

  @override
  void initState() {
    super.initState();
    _taskMarker = Marker(
      markerId: MarkerId('taskLocation'),
      position:
          LatLng(widget.task.location.latitude, widget.task.location.longitude),
    );
    _setCurrentLocation();
  }

  void _setCurrentLocation() {
    setState(() {
      _currentLocation =
          LatLng(widget.task.location.latitude, widget.task.location.longitude);
    });
  }

  Future<void> _markAsComplete() async {
    await FirebaseFirestore.instance
        .collection('tasks')
        .doc(widget.task.taskId)
        .update({'state': 'completed'});

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Task marked as completed!')),
    );

    Navigator.pop(context);
  }

  Future<void> _navigateToWorkerMap() async {
    final LatLng? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WorkerMapPage(
          userLocation: LatLng(
              widget.task.location.latitude, widget.task.location.longitude),
        ),
      ),
    );

    if (result != null) {
      setState(() {
        _workerLocation = result;
      });
      // You might want to save this location or use it for further processing
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task.name),
        backgroundColor: const Color.fromARGB(255, 107, 100, 237),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Address: ${widget.task.address}',
                style: TextStyle(fontSize: 16)),
            Text('Email: ${widget.task.email}', style: TextStyle(fontSize: 16)),
            Text('Phone Number: ${widget.task.phoneNumber}',
                style: TextStyle(fontSize: 16)),
            Text('State: ${widget.task.state}', style: TextStyle(fontSize: 16)),
            Text('Role: ${widget.task.role}', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            Text(
                'Location: ${widget.task.location.latitude}, ${widget.task.location.longitude}',
                style: TextStyle(fontSize: 16)),
            if (_workerLocation != null)
              Text(
                  'Worker Location: ${_workerLocation!.latitude}, ${_workerLocation!.longitude}',
                  style: TextStyle(fontSize: 16)),
            Text('Map Address: ${widget.task.map}',
                style: TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            SizedBox(
              height: 300.0,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(widget.task.location.latitude,
                      widget.task.location.longitude),
                  zoom: 15,
                ),
                markers: {
                  _taskMarker,
                  Marker(
                    markerId: MarkerId('currentLocation'),
                    position: _currentLocation,
                  ),
                  if (_workerLocation != null)
                    Marker(
                      markerId: MarkerId('workerLocation'),
                      position: _workerLocation!,
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueBlue),
                    ),
                },
                onMapCreated: (GoogleMapController controller) {
                  _mapController = controller;
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _navigateToWorkerMap,
              child: Text('Select Worker Location'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _markAsComplete,
              child: Text('Mark as Complete'),
            ),
          ],
        ),
      ),
    );
  }
}
