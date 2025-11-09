import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart' as AppSettings;
import 'package:provider/provider.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../../provider/color_provider.dart';
import '../../../../../util/button_icon.dart';
import '../../../../../util/snackbar_helper.dart';
import '../../../../../provider/notification_provider.dart';
import '../notification_screen.dart';
import '../notification_service.dart';

class NotificationMessageInputSection extends StatefulWidget {
  final TextEditingController titleController;
  final TextEditingController messageController;
  final ReminderType reminderType;
  final TimeOfDay selectedTime;
  final int intervalDays;
  final NotificationMode mode;
  final List<bool> selectedWeekDays;
  final void Function(Map<String, dynamic>) onAdd;

  const NotificationMessageInputSection({
    super.key,
    required this.titleController,
    required this.messageController,
    required this.reminderType,
    required this.selectedTime,
    required this.intervalDays,
    required this.mode,
    required this.selectedWeekDays,
    required this.onAdd,
  });

  @override
  State<NotificationMessageInputSection> createState() =>
      _NotificationMessageInputSectionState();
}

class _NotificationMessageInputSectionState
    extends State<NotificationMessageInputSection> {
  bool showMessageInput = true;

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
    final t = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionContainer(
          Column(
            children: [
              _buildIconLabelRow(
                icon: Icons.message_outlined,
                label: t.notificationForm_titleLabel,
                colorProvider: colorProvider,
              ),
              const SizedBox(height: 8),
              _buildTextField(
                controller: widget.titleController,
                hint: t.notificationForm_titleHint,
                colorProvider: colorProvider,
              ),
            ],
          ),
          colorProvider,
        ),
        const SizedBox(height: 16),
        _sectionContainer(
          Column(
            children: [
              _buildIconLabelRow(
                icon: Icons.message,
                label: t.notificationForm_messageLabel,
                colorProvider: colorProvider,
              ),
              const SizedBox(height: 8),
              _buildTextField(
                controller: widget.messageController,
                hint: t.notificationForm_messageHint,
                colorProvider: colorProvider,
              ),
            ],
          ),
          colorProvider,
        ),
        const SizedBox(height: 12),
        _sectionContainer(
          Row(
            children: [
              // Okrągły przycisk testowy z tooltipem
              Tooltip(
                message: t.notificationForm_testNotification,
                child: Container(
                  decoration: BoxDecoration(
                    color: colorProvider.accent.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () async {
                      if (!await _ensureNotificationPermission()) return;

                      _sendInstantNotification(
                        context: context,
                        title: widget.titleController.text,
                        body:
                            showMessageInput ? widget.messageController.text : '',
                        payload: 'type:${widget.reminderType.name}',
                      );
                    },
                    icon: Icon(Icons.notifications_active_outlined,
                        color: colorProvider.accent),
                    splashRadius: 20,
                    // mniejszy splashRadius też fajnie wygląda przy mniejszym przycisku
                    tooltip: t.notificationForm_testNotification,
                    constraints: const BoxConstraints(),
                    // usuwa domyślne minimalne constraints IconButton
                    padding:
                        EdgeInsets.zero, // usuwa padding wbudowany w IconButton
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // Przycisk dodaj zajmujący pozostałą szerokość
              Expanded(
                child: ButtonIcon(
                  onPressed: () async {
                    if (!await _ensureNotificationPermission()) return;

                    final notificationData = {
                      'type': widget.reminderType,
                      'mode': widget.mode,
                      'time': widget.selectedTime,
                      'message':
                          showMessageInput ? widget.messageController.text : '',
                      'interval': widget.intervalDays,
                      'weekdays': List<bool>.from(widget.selectedWeekDays),
                      'title': widget.titleController.text,
                    };

                    await Provider.of<NotificationProvider>(
                      context,
                      listen: false,
                    ).saveNotification(
                      hour: widget.selectedTime.hour,
                      minute: widget.selectedTime.minute,
                      intervalDays: widget.intervalDays,
                      mode: widget.mode.name,
                      type: widget.reminderType.name,
                      weekdays: List<bool>.from(widget.selectedWeekDays),
                      message:
                          showMessageInput ? widget.messageController.text : '',
                      title: widget.titleController.text,
                    );

                    widget.onAdd(notificationData);
                    SnackbarHelper.showSnackbar(
                        context, t.notificationForm_added);
                  },
                  iconData: Icons.add,
                  labelText: t.notificationForm_addNotification,
                  showBorder: false,
                ),
              ),
            ],
          ),
          colorProvider,
        ),
      ],
    );
  }

  Widget _buildIconLabelRow({
    required IconData icon,
    required String label,
    required ColorProvider colorProvider,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: colorProvider.accent.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(8),
              child: Icon(icon, color: colorProvider.accent, size: 20),
            ),
            const SizedBox(width: 12),
            Text(label, style: TextStyle(color: colorProvider.accent, fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required ColorProvider colorProvider,
  }) {
    return TextFormField(
      controller: controller,
      minLines: 1,
      maxLines: null,
      style: TextStyle(color: colorProvider.accent),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: colorProvider.accent.withOpacity(0.5)),
        filled: true,
        fillColor: colorProvider.accent.withOpacity(0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  void _sendInstantNotification({
    required BuildContext context,
    required String title,
    required String body,
    required String payload,
  }) async {
    final notificationService = NotificationService();

    await notificationService.sendInstantNotification(
      title: title,
      body: body,
      payload: payload,
    );

    SnackbarHelper.showSnackbar(
        context, 'Testowe powiadomienie zostało wysłane');
  }

  Widget _sectionContainer(Widget child, ColorProvider colorProvider) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: colorProvider.accent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }

  Future<bool> _ensureNotificationPermission() async {
    final service = NotificationService();
    final granted = await service.checkAndRequestPermissions();
    if (!granted) {
      AppSettings.openAppSettings();
      return false;
    }
    return granted;
  }
}
