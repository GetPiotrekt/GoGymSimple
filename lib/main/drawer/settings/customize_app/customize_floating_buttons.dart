import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Import your provider
import '../../../../provider/color_provider.dart';
import 'add_pattern.dart';


class CustomizeFloatingButtons extends StatelessWidget {
  final VoidCallback refreshScreen;

  const CustomizeFloatingButtons({
    super.key,
    required this.refreshScreen,
  });

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context); // Access color provider

    return FloatingActionButton(
      onPressed: () async {

          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPattern(
              primaryBasic: colorProvider.primary,
              secondaryBasic: colorProvider.secondary,
              accentBasic: colorProvider.accent,
            )),
          );
          refreshScreen(); // Refresh the screen after returning
        },
      backgroundColor: colorProvider.accent, // Button background color
      foregroundColor: colorProvider.secondary, // Icon color
      child: const Icon(
        Icons.add,
      ),
    );
  }
}
