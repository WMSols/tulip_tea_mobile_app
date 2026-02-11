import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:iconsax/iconsax.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:tulip_tea_order_booker/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_order_booker/core/utils/app_fonts/app_fonts.dart';
import 'package:tulip_tea_order_booker/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_order_booker/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_order_booker/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_order_booker/core/widgets/buttons/app_button.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:tulip_tea_order_booker/core/widgets/form/app_form_field_label/app_form_field_label.dart';
import 'package:tulip_tea_order_booker/core/widgets/form/app_location_picker/location_picker_lat_lng_display.dart';
import 'package:tulip_tea_order_booker/core/widgets/form/app_location_picker/location_picker_map.dart';

/// Reusable location picker: map preview, "Select Current Location" button,
/// optional read-only address when a location is set, and lat/long display.
/// Tapping the map opens that location in Google Maps.
class AppLocationPicker extends StatefulWidget {
  const AppLocationPicker({
    super.key,
    this.label,
    this.required = false,
    required this.lat,
    required this.lng,
    required this.onLocationSelected,
    this.onLocationCleared,
  });

  final String? label;
  final bool required;
  final String lat;
  final String lng;
  final void Function(double lat, double lng) onLocationSelected;

  /// Called when the user clears the selected location (e.g. via clear icon).
  final VoidCallback? onLocationCleared;

  static const LatLng _defaultCenter = LatLng(31.5204, 74.3587);

  /// Zoom level when a location is selected (street level; 15 ≈ 20 m).
  static const double _selectedLocationZoom = 17.5;

  /// Decimal places for coordinates when opening in Google Maps (6 ≈ 0.1 m accuracy).
  static const int _googleMapsCoordinatePrecision = 6;

  @override
  State<AppLocationPicker> createState() => _AppLocationPickerState();
}

class _AppLocationPickerState extends State<AppLocationPicker> {
  late final MapController _mapController = MapController();

  bool _isLoadingLocation = false;
  String? _errorMessage;
  String? _addressText;

  @override
  void initState() {
    super.initState();
    _loadAddressFromCoordinates();
  }

  /// When the widget has existing lat/lng, resolve address for read-only display.
  Future<void> _loadAddressFromCoordinates() async {
    final lat = double.tryParse(widget.lat.trim());
    final lng = double.tryParse(widget.lng.trim());
    if (lat == null || lng == null) return;
    try {
      final placemarks = await placemarkFromCoordinates(lat, lng);
      if (!mounted) return;
      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        final parts = [
          if (p.name != null && p.name!.isNotEmpty) p.name,
          if (p.locality != null && p.locality!.isNotEmpty) p.locality,
          if (p.administrativeArea != null && p.administrativeArea!.isNotEmpty)
            p.administrativeArea,
          if (p.country != null && p.country!.isNotEmpty) p.country,
        ].whereType<String>().toList();
        if (parts.isNotEmpty) {
          setState(() => _addressText = parts.join(', '));
        }
      }
    } catch (_) {}
  }

  @override
  void didUpdateWidget(covariant AppLocationPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.lat != widget.lat || oldWidget.lng != widget.lng) {
      _loadAddressFromCoordinates();
    }
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  LatLng get _currentCenter {
    final lat = double.tryParse(widget.lat.trim());
    final lng = double.tryParse(widget.lng.trim());
    if (lat != null && lng != null) return LatLng(lat, lng);
    return AppLocationPicker._defaultCenter;
  }

  bool get _hasLocation {
    final lat = double.tryParse(widget.lat.trim());
    final lng = double.tryParse(widget.lng.trim());
    return lat != null && lng != null;
  }

  void _moveMapTo(LatLng point) {
    _mapController.move(point, AppLocationPicker._selectedLocationZoom);
  }

  void _clearLocation() {
    setState(() {
      _addressText = null;
      _errorMessage = null;
    });
    widget.onLocationCleared?.call();
  }

  Future<void> _selectCurrentLocation() async {
    setState(() {
      _errorMessage = null;
      _isLoadingLocation = true;
    });
    try {
      final permission = await Permission.location.request();
      if (!permission.isGranted) {
        if (mounted) {
          setState(() {
            _errorMessage =
                'Location permission is required to select current location.';
            _isLoadingLocation = false;
          });
        }
        return;
      }
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (mounted) {
          setState(() {
            _errorMessage =
                'Location services are disabled. Please enable them.';
            _isLoadingLocation = false;
          });
        }
        return;
      }
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
      if (!mounted) return;
      widget.onLocationSelected(position.latitude, position.longitude);
      _moveMapTo(LatLng(position.latitude, position.longitude));

      String addressText =
          '${position.latitude.toStringAsFixed(4)}, ${position.longitude.toStringAsFixed(4)}';
      try {
        final placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );
        if (placemarks.isNotEmpty) {
          final p = placemarks.first;
          final parts = [
            if (p.name != null && p.name!.isNotEmpty) p.name,
            if (p.locality != null && p.locality!.isNotEmpty) p.locality,
            if (p.administrativeArea != null &&
                p.administrativeArea!.isNotEmpty)
              p.administrativeArea,
            if (p.country != null && p.country!.isNotEmpty) p.country,
          ].whereType<String>().toList();
          if (parts.isNotEmpty) addressText = parts.join(', ');
        }
      } catch (_) {}
      if (mounted) {
        setState(() {
          _addressText = addressText;
          _errorMessage = null;
          _isLoadingLocation = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage =
              'Could not get location: ${e.toString().replaceFirst('Exception: ', '')}';
          _isLoadingLocation = false;
        });
      }
    }
  }

  Future<void> _openInGoogleMaps({double? lat, double? lng}) async {
    final latitude =
        lat ?? double.tryParse(widget.lat.trim()) ?? _currentCenter.latitude;
    final longitude =
        lng ?? double.tryParse(widget.lng.trim()) ?? _currentCenter.longitude;
    final latStr = latitude.toStringAsFixed(
      AppLocationPicker._googleMapsCoordinatePrecision,
    );
    final lngStr = longitude.toStringAsFixed(
      AppLocationPicker._googleMapsCoordinatePrecision,
    );
    final uri = Uri.parse('https://www.google.com/maps?q=$latStr,$lngStr');
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      if (mounted) {
        setState(() => _errorMessage = 'Could not open Google Maps.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppFormFieldLabel(label: widget.label, required: widget.required),
        if (_hasLocation &&
            (_addressText != null && _addressText!.isNotEmpty)) ...[
          Row(
            children: [
              Expanded(
                child: Text(
                  _addressText!,
                  style: AppTextStyles.bodyText(context).copyWith(
                    fontFamily: AppFonts.primaryFont,
                    color: AppColors.grey,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (widget.onLocationCleared != null)
                IconButton(
                  icon: const Icon(Iconsax.close_circle),
                  color: AppColors.error,
                  onPressed: _clearLocation,
                ),
            ],
          ),
          AppSpacing.vertical(context, 0.01),
        ],
        LocationPickerMap(
          center: _currentCenter,
          showMarker: _hasLocation,
          onMapTap: (lat, lng) => _openInGoogleMaps(lat: lat, lng: lng),
          height: 200,
          mapController: _mapController,
          initialZoom: _hasLocation
              ? AppLocationPicker._selectedLocationZoom
              : null,
        ),
        AppSpacing.vertical(context, 0.015),
        AppButton(
          label: AppTexts.selectCurrentLocation,
          onPressed: _isLoadingLocation ? null : _selectCurrentLocation,
          isLoading: _isLoadingLocation,
          primary: false,
          icon: Iconsax.location,
          iconPosition: IconPosition.left,
        ),
        AppSpacing.vertical(context, 0.01),
        LocationPickerLatLngDisplay(lat: widget.lat, lng: widget.lng),
        if (_errorMessage != null && _errorMessage!.isNotEmpty) ...[
          AppSpacing.vertical(context, 0.006),
          Text(_errorMessage!, style: AppTextStyles.errorText(context)),
        ],
      ],
    );
  }
}
