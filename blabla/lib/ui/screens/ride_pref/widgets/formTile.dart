import 'package:flutter/material.dart';

class TileCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final IconData? trailingButton;
  final VoidCallback? reverseLocation;
  final VoidCallback? tapAction;
  const TileCard({
    super.key,
    required this.icon,
    required this.title,
    this.trailingButton,
    this.reverseLocation,
    this.tapAction
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: tapAction,
      trailing: IconButton(
        onPressed: reverseLocation,
        icon: Icon(trailingButton),
      ),
    );
  }
}
