import 'package:GoGymSimple/util/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../l10n/app_localizations.dart';
import '../../../provider/color_provider.dart';
import '../../../util/button_icon.dart';
import '../../../util/snackbar_helper.dart';  // import klasy SnackbarHelper

class ShareApp extends StatelessWidget {
  const ShareApp({super.key});

  final String _shareLink = 'https://appname.com/download';

  void _copyLink(BuildContext context) {
    Clipboard.setData(ClipboardData(text: _shareLink));
    SnackbarHelper.showSnackbar(context, AppLocalizations.of(context)!.shareApp_linkCopied);
  }

  void _shareLinkFunc(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final text = t.shareApp_shareText;
    Share.share('$text $_shareLink');
  }

  @override
  Widget build(BuildContext context) {
    final cp = context.watch<ColorProvider>();
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: cp.primary,
      appBar: CustomAppBar(
        title: t.shareApp_title,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 12),
              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cp.secondary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: cp.accent, width: 2),
                      ),
                      child: ClipOval(
                        child: Container(
                          color: cp.accent.withOpacity(0.1),
                          child: Padding(
                            padding: const EdgeInsets.all(1),
                            child: Image.asset(
                              'assets/icons/logo_bl.png',
                              fit: BoxFit.cover,
                              color: cp.accent,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'GoGymSimple',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: cp.accent,
                      ),
                    ),
                    Text(
                      'Version 1.0.0',
                      style: TextStyle(color: cp.accent.withOpacity(0.7)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cp.secondary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Text(
                      t.shareApp_inviteTitle,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: cp.accent,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      t.shareApp_inviteSubtitle,
                      style: TextStyle(color: cp.accent.withOpacity(0.7)),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: cp.accent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              _shareLink,
                              style: TextStyle(color: cp.accent),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.copy, color: cp.accent),
                            onPressed: () => _copyLink(context),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.maxFinite,
                      child: ButtonIcon(
                        onPressed: () => _shareLinkFunc(context),
                        iconData: Icons.share,
                        labelText: t.shareApp_shareButton,
                        backgroundColor: cp.accent.withOpacity(0.1),
                        textColor: cp.accent,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
