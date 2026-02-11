import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import 'package:flutter_map/flutter_map.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_responsive/app_responsive.dart';

/// Reusable map preview with optional marker. Single tap opens the tapped
/// (or current) location in Google Maps via [onMapTap].
/// Pass [mapController] from parent to control the map (e.g. move to new location).
class LocationPickerMap extends StatefulWidget {
  const LocationPickerMap({
    super.key,
    required this.center,
    required this.showMarker,
    required this.onMapTap,
    this.height,
    this.mapController,
    this.initialZoom,
  });

  final LatLng center;
  final bool showMarker;
  final void Function(double lat, double lng) onMapTap;
  final double? height;

  /// If provided, this controller is used and not disposed by this widget.
  final MapController? mapController;

  /// Zoom level. If null, uses [defaultZoom]. Use higher zoom (e.g. 15) when a location is selected.
  final double? initialZoom;

  static const double defaultZoom = 10.0;

  @override
  State<LocationPickerMap> createState() => _LocationPickerMapState();
}

class _LocationPickerMapState extends State<LocationPickerMap> {
  MapController? _ownController;

  MapController get _mapController => widget.mapController ?? _ownController!;

  @override
  void initState() {
    super.initState();
    if (widget.mapController == null) {
      _ownController = MapController();
    }
  }

  @override
  void dispose() {
    _ownController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = widget.height ?? 200.0;
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppResponsive.radius(context)),
      child: SizedBox(
        height: AppResponsive.scaleSize(context, height),
        width: double.infinity,
        child: FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: widget.center,
            initialZoom: widget.initialZoom ?? LocationPickerMap.defaultZoom,
            interactionOptions: const InteractionOptions(
              flags: InteractiveFlag.drag | InteractiveFlag.pinchZoom,
            ),
            onTap: (_, point) =>
                widget.onMapTap(point.latitude, point.longitude),
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'tulip_tea_mobile_app',
            ),
            if (widget.showMarker)
              MarkerLayer(
                markers: [
                  Marker(
                    point: widget.center,
                    width: AppResponsive.scaleSize(context, 40),
                    height: AppResponsive.scaleSize(context, 40),
                    child: Icon(
                      Icons.location_pin,
                      color: AppColors.error,
                      size: AppResponsive.iconSize(context, factor: 1.5),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
