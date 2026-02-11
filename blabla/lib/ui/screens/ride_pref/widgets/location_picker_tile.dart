import 'package:flutter/material.dart';

class LocationPickerTile extends StatelessWidget {
  final IconData icon;
  final String location;
  final String country;
  final VoidCallback onTap;
  final Color backgroundColor;

  const LocationPickerTile({
    super.key,
    required this.icon,
    required this.country,
    required this.location,
    required this.onTap,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(location),
      subtitle: Text(country),
      selectedColor: backgroundColor,
      onTap: onTap,
    );
  }
}
