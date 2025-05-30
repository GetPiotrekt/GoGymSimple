import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/color_provider.dart';
import '../../provider/selected_options_provider.dart';
import '../../provider/time_provider.dart';
import '../../provider/settings_provider.dart'; // Dodajemy import
import '../drawer/drawer.dart';
import '../drawer/tools/time/stopwatch.dart';
import 'exercise_view/exercise_view.dart';
import 'history_view/history_view.dart';
import 'search_drawer.dart';
import 'tab_sector/tab_sector.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final SearchDrawer _searchDrawer = SearchDrawer();

  @override
  Widget build(BuildContext context) {
    final colorProvider = context.watch<ColorProvider>();
    final selectedOptions = context.watch<SelectedOptionsProvider>();
    final settingsProvider = context.watch<SettingsProvider>();

    return Scaffold(
      backgroundColor: colorProvider.primary,
      appBar: AppBar(
        backgroundColor: colorProvider.secondary,
        foregroundColor: colorProvider.accent,
        centerTitle: true,
        title: Text(
          'GoGymSimple',
          style: TextStyle(
            fontFamily: 'BarlowSemiCondensed',
            fontSize: 36,
            fontWeight: FontWeight.w600,
            color: colorProvider.accent,
          ),
        ),
        actions: [
          IconButton(
            icon: selectedOptions.searchQuery.isEmpty
                ? Icon(Icons.search, color: colorProvider.accent)
                : Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorProvider.accent,
              ),
              padding: const EdgeInsets.all(6),
              child: Icon(
                Icons.clear,
                color: colorProvider.primary,
              ),
            ),
            onPressed: () {
              if (selectedOptions.searchQuery.isEmpty) {
               _searchDrawer.open(context); // Otwieramy szufladę wyszukiwania
              } else {
                selectedOptions.setSearchQuery(''); // Czyścimy zapytanie wyszukiwania
              }
            },
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabSector(colorProvider: colorProvider),
          Container(height: 1, color: colorProvider.accent.withOpacity(0.7)),
          Expanded(
            child: selectedOptions.viewMode == 'List'
                ? const ExerciseView() // Pokazuje ExerciseView, gdy tryb to 'List'
                : const HistoryView(), // W przeciwnym razie pokazuje HistoryView
          ),
        ],
      ),
      floatingActionButton: (settingsProvider.getElementVisibility &&
          MediaQuery.of(context).viewInsets.bottom == 0)
          ? Builder(
        builder: (context) {
          final timeProvider = context.watch<TimeProvider>();
          final colorProvider = context.watch<ColorProvider>();

          return GestureDetector(
            onLongPress: () {
              timeProvider.reset(); // reset po przytrzymaniu
            },
            child: FloatingActionButton.extended(
              elevation: 3,
              backgroundColor: colorProvider.secondary,
              foregroundColor: colorProvider.accent,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const StopwatchScreen()),
                );
              },
              label: Row(
                children: [
                  const Icon(Icons.timer_outlined, size: 30),
                  const SizedBox(width: 8),
                  Text(
                    timeProvider.formattedElapsed,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () {
                      if (timeProvider.isRunning) {
                        timeProvider.stop();
                      } else {
                        timeProvider.start();
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: colorProvider.accent, width: 1.5),
                      ),
                      child: Icon(
                        timeProvider.isRunning ? Icons.pause : Icons.play_arrow,
                        size: 18,
                        color: colorProvider.accent,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      timeProvider.reset();
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 8),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: colorProvider.accent, width: 1.5),
                      ),
                      child: Icon(
                        Icons.replay,
                        size: 18,
                        color: colorProvider.accent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      )
          : null,
    );
  }
}
