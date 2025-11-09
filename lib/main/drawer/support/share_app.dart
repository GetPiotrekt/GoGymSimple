import 'package:GoGymSimple/util/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../l10n/app_localizations.dart';
import '../../../provider/color_provider.dart';
import '../../../util/button_icon.dart';
import '../../../util/snackbar_helper.dart';  // import klasy SnackbarHelper

class ShareApp extends StatelessWidget {
  const ShareApp({super.key});

  final String _shortLink = 'https://play.google.com/store/apps';
  final String _shareLink = 'https://play.google.com/store/apps/details?id=piotr.wisnia.go_gym_simple';

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
                    FittedBox(
                      child: Text(
                        t.shareApp_inviteTitle,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: cp.accent,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
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
                              _shortLink,
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
                      t.shareApp_ratingTitle, // np. "Enjoying GoGymSimple?"
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: cp.accent,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      t.shareApp_ratingSubtitle, // np. "Would you like to rate GoGymSimple? Your review helps others discover the app."
                      style: TextStyle(
                        color: cp.accent.withOpacity(0.7),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextButton.icon(
                            onPressed: () async {
                              final Uri url = Uri.parse('https://play.google.com/store/apps/details?id=piotr.wisnia.go_gym_simple&reviewId=0');
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url, mode: LaunchMode.externalApplication);
                              }
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: cp.accent.withOpacity(0.1),
                              foregroundColor: cp.accent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            icon: Icon(Icons.thumb_up, color: cp.accent),
                            label: Text(
                              t.shareApp_ratingYes,
                              style: TextStyle(color: cp.accent),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                decoration: BoxDecoration(
                  color: cp.secondary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      t.shareApp_feedbackTitle, // np. "Masz pomysł?"
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: cp.accent,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      t.shareApp_feedbackSubtitle, // np. "Jeśli masz pomysł, co mogłoby się pojawić w aplikacji – napisz prywatną wiadomość na Instagramie! To przywilej dla pierwszych użytkowników GoGymSimple 💪"
                      style: TextStyle(
                        color: cp.accent.withOpacity(0.7),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    TextButton.icon(
                      onPressed: () async {
                        final Uri url = Uri.parse('https://www.instagram.com/wisnia.55/'); // ← Twój Instagram
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url, mode: LaunchMode.externalApplication);
                        }
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: cp.accent.withOpacity(0.1),
                        foregroundColor: cp.accent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      icon: Icon(Icons.send, color: cp.accent),
                      label: Text(
                        t.shareApp_feedbackButton, // np. "Napisz na Instagramie"
                        style: TextStyle(color: cp.accent),
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
