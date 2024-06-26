import 'package:location/location.dart';

class LocationHelper {
  double? latitude;
  double? longitude;

  Future<void> getCurrentLocation() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    try {
      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return;
        }
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return;
        }
      }

      _locationData = await location.getLocation();
      latitude = _locationData.latitude;
      longitude = _locationData.longitude;
    } catch (e) {
      // Handle the error, e.g., by logging it or showing a user message
      print('An error occurred while getting the location: $e');
    }
  }
}
