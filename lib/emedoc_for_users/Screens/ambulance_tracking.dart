import 'dart:async';
import 'package:emedoc/emedoc_for_users/repositories/map_repository.dart';
import 'package:emedoc/models/hospital_model.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class AmbulanceTracking extends StatefulWidget {
  const AmbulanceTracking({
    super.key,
    required this.hospital,
  });
  final Hospitalinfo hospital;

  @override
  State<AmbulanceTracking> createState() => _AmbulanceTrackingState();
}

class _AmbulanceTrackingState extends State<AmbulanceTracking> {
  Location _locationController = new Location();

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  static const LatLng _pGooglePlex = LatLng(37.4223, -122.0848);
  static const LatLng _pApplePark = LatLng(37.3346, -122.0090);

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    getLocationUpdates();
  }

  Position? _currentPosition;
  LatLng? _currentP;
  void getCurrentLocation() async {
    Position cP = await determinePosition();
    setState(() {
      _currentPosition = cP;
      _currentP = LatLng(cP.latitude, cP.longitude);
    });
  }

  Future<void> getLocationUpdates() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _locationController.serviceEnabled();
    if (_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
    } else {
      return;
    }

    _permissionGranted = await _locationController.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationController.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          _currentP =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
          _cameraToPosition(_currentP!);
        });
      }
    });
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCameraPosition = CameraPosition(
      target: pos,
      zoom: 13,
    );
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(_newCameraPosition),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_currentPosition == null) {
      return const Scaffold(
        body: Center(
          child: Text('Getting Current Location...'),
        ),
      );
    }
    return Scaffold(
      // body: GoogleMap(
      //   initialCameraPosition: CameraPosition(
      //     target: LatLng(
      //       double.parse(widget.hospital.latitude),
      //       double.parse(widget.hospital.longtitude),
      //     ),
      //     zoom: 13,
      //   ),
      //   polylines: Set<Polyline>.of(polylines.values),
      // ),
      body: GoogleMap(
        onMapCreated: ((GoogleMapController controller) =>
            _mapController.complete(controller)),
        initialCameraPosition: const CameraPosition(
          target: _pGooglePlex,
          zoom: 13,
        ),
        markers: {
          Marker(
            markerId: const MarkerId("_currentLocation"),
            icon: BitmapDescriptor.defaultMarker,
            position: _currentP!,
          ),
          const Marker(
              markerId: MarkerId("_ambulanceLocation"),
              icon: BitmapDescriptor.defaultMarker,
              position: _pGooglePlex),
          const Marker(
              markerId: MarkerId("_destionationLocation"),
              icon: BitmapDescriptor.defaultMarker,
              position: _pApplePark)
        },
      ),
    );
  }
}
