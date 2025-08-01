import 'dart:developer';
import 'package:location/location.dart' as loc;
import 'package:geolocator/geolocator.dart' as geo;

class LocationService {
  final loc.Location location = loc.Location();

  Future<loc.LocationData?> askAndGetUserLocation() async {
    try {
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          return null;
        }
      }

      loc.PermissionStatus permissionGranted = await location.hasPermission();
      if (permissionGranted == loc.PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != loc.PermissionStatus.granted) {
          return null;
        }
      }

      await location.changeSettings(accuracy: loc.LocationAccuracy.balanced);

      final userPosition = await location.getLocation();
      if (userPosition.latitude == null || userPosition.longitude == null) {
        return null;
      }

      return userPosition;
    } catch (e) {
      log("Error getting user location", error: e);
      return null;
    }
  }

  Future<geo.Position?> getLocationWebSafe() async {
    bool serviceEnabled = await geo.Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }

    geo.LocationPermission permission = await geo.Geolocator.checkPermission();
    if (permission == geo.LocationPermission.denied) {
      permission = await geo.Geolocator.requestPermission();
      if (permission == geo.LocationPermission.denied) {
        return null;
      }
    }

    return await geo.Geolocator.getCurrentPosition(
      locationSettings: geo.LocationSettings(
        accuracy: geo.LocationAccuracy.medium,
        distanceFilter: 10,
      ),
    );
  }
}
