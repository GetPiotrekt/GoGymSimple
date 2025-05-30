import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';
import '../../provider/color_provider.dart';
import '../../provider/selected_options_provider.dart';
import '../../util/bottom_sheet.dart';
import '../../util/input_form_field/input_decorations.dart';

class SearchDrawer {
  void open(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Consumer<ColorProvider>(
        builder: (context, colorProvider, _) => BottomSheetTemplate(
          onPressed: () {}, // Można dodać logikę resetowania wyszukiwania
          child: _buildSearchContent(context, colorProvider),
        ),
      ),
    );
  }

  Widget _buildSearchContent(BuildContext context, ColorProvider colorProvider) {
    final searchController = TextEditingController();
    final selectedOptions = context.read<SelectedOptionsProvider>();
    final t = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: searchController,
          autofocus: true,
          style: TextStyle(color: colorProvider.accent, fontSize: 18),
          decoration: CustomInputDecorations.buildInputDecoration(
            context,
            t.searchDrawer_hint,
            isLabelVisible: false,
          ).copyWith(
            prefixIcon: Icon(Icons.search, color: colorProvider.accent),
            suffixIcon: IconButton(
              tooltip: t.searchDrawer_clear,
              icon: Icon(Icons.clear, color: colorProvider.accent),
              onPressed: () {
                searchController.clear();
                selectedOptions.setSearchQuery('');
              },
            ),
          ),
          onChanged: (value) => selectedOptions.setSearchQuery(value),
          onSubmitted: (value) {
            FocusScope.of(context).unfocus(); // Ukryj klawiaturę
            Navigator.of(context).pop(); // Zamknij BottomSheet
          },
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
