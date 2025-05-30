import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../provider/color_provider.dart';
import '../../../../provider/selected_options_provider.dart';
import '../../../../util/dropdown.dart';
import '../../../l10n/app_localizations.dart';

class SortSector extends StatelessWidget {
  const SortSector({super.key});

  @override
  Widget build(BuildContext context) {
    final cp = Provider.of<ColorProvider>(context);
    final t = AppLocalizations.of(context)!;

    // Styl tekstu spójny dla obu przycisków
    final TextStyle buttonTextStyle = TextStyle(
      fontSize: 16,
      fontFamily: 'BarlowSemiCondensed',
      fontWeight: FontWeight.w600,
      color: cp.accent,
    );

    return Container(
      width: double.maxFinite,
      color: cp.secondary,
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
      child: Row(
        children: [
          Expanded(child: _buildSortDropdown(context, cp, t, buttonTextStyle)),
          const SizedBox(width: 8),
          Expanded(child: _buildViewToggle(context, cp, t, buttonTextStyle)),
        ],
      ),
    );
  }

  Widget _buildSortDropdown(BuildContext context, ColorProvider colorProvider, AppLocalizations t, TextStyle textStyle) {
    final selectedOptions = Provider.of<SelectedOptionsProvider>(context);
    final bool isExerciseView = selectedOptions.viewMode == 'List';
    final sortOptions = _getSortOptions(isExerciseView, t);

    String? selectedSort = isExerciseView
        ? selectedOptions.sortExerciseView
        : selectedOptions.sortHistoryView;

    // Make sure selectedSort is a valid key
    if (!sortOptions.containsKey(selectedSort)) {
      selectedSort = sortOptions.keys.first;
    }

    return Container(
      decoration: CustomDropdown.dropdownDecoration(colorProvider),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: selectedSort,
          dropdownColor: colorProvider.secondary,
          icon: Icon(Icons.sort, color: colorProvider.accent),
          style: textStyle,
          items: sortOptions.entries.map((entry) {
            return DropdownMenuItem<String>(
              value: entry.key,
              child: Row(
                children: [
                  Icon(Icons.arrow_right_outlined, color: colorProvider.accent),
                  const SizedBox(width: 2),
                  Text(entry.value, style: textStyle),
                ],
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              selectedOptions.setSelectedOption(
                'Sort',
                newValue,
                context: isExerciseView ? 'ExerciseView' : 'HistoryView',
              );
            }
          },
        ),
      ),
    );
  }


  Widget _buildViewToggle(BuildContext context, ColorProvider colorProvider, AppLocalizations t, TextStyle textStyle) {
    return Consumer<SelectedOptionsProvider>(
      builder: (context, selectedOptions, _) {
        bool isHistoryView = selectedOptions.viewMode == 'History';

        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: colorProvider.accent.withOpacity(0.1),
            foregroundColor: colorProvider.accent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            minimumSize: const Size.fromHeight(48),
            textStyle: textStyle, // Ustawienie spójnego stylu tekstu
          ),
          onPressed: () {
            selectedOptions.setSelectedOption('ViewMode', isHistoryView ? 'List' : 'History');
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isHistoryView ? t.sortSector_exerciseView : t.sortSector_historyView,
                style: textStyle,
              ),
              const SizedBox(width: 2),
              Icon(isHistoryView ? Icons.view_list : Icons.history),
            ],
          ),
        );
      },
    );
  }

  Map<String, String> _getSortOptions(bool isExerciseView, AppLocalizations t) {
    return isExerciseView
        ? {
      'aToZ': t.sortSector_aToZ,
      'zToA': t.sortSector_zToA,
    }
        : {
      'newest': t.sortSector_newest,
      'oldest': t.sortSector_oldest,
    };
  }
}
