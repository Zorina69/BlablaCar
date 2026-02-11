import 'package:blabla/model/ride/locations.dart';
import 'package:blabla/services/location_service.dart';
import 'package:blabla/ui/screens/ride_pref/widgets/location_picker_tile.dart';
import 'package:blabla/ui/theme/theme.dart';
import 'package:flutter/material.dart';

class LocationPickerScreen extends StatefulWidget {
  final Location? selectedLocation;
  const LocationPickerScreen({super.key, this.selectedLocation});

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  final _locationController = TextEditingController();

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Filter locations based on input
    final filteredLocations = LocationsService.availableLocations
        .where(
          (loc) => loc.name.toLowerCase().contains(
            _locationController.text.toLowerCase(),
          ),
        )
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Pick Location')),
      body: Column(
        children: [
          // Search Field
          Padding(
            padding: const EdgeInsets.all(BlaSpacings.m),
            child: TextFormField(
              controller: _locationController,
              decoration: const InputDecoration(
                labelText: 'Search Location',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (_) {
                setState(() {}); // rebuild list as user types
              },
            ),
          ),

          // Location List
          Expanded(
            child: ListView.builder(
              itemCount: filteredLocations.length,
              itemBuilder: (context, index) {
                final loc = filteredLocations[index];
                final isSelected = loc == widget.selectedLocation;

                return LocationPickerTile(
                  location: loc.name,
                  country: loc.country.toString(),
                  icon: Icons.location_city,
                  backgroundColor: isSelected
                      ? BlaColors.primary
                      : Colors.white,
                  onTap: () {
                    Navigator.pop(context, loc); // return selected location
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
