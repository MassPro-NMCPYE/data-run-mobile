import 'package:d2_remote/modules/datarun/form/entities/data_form_submission.entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mass_pro/data_run/screens/form_submission_list/model/submission_list.provider.dart';
import 'package:mass_pro/data_run/screens/form_submission_list/model/submission_summary.model.dart';
import 'package:mass_pro/data_run/screens/form_ui_elements/get_error_widget.dart';
import 'package:mass_pro/data_run/screens/form_ui_elements/q_sync_icon_button.widget.dart';
import 'package:mass_pro/data_run/screens/form_submission_list/submission_list_screen.widget.dart';
import 'package:mass_pro/generated/l10n.dart';

class SubmissionSummary extends ConsumerStatefulWidget {
  const SubmissionSummary(
      {super.key,
      this.onTap,
      required this.form,
      required this.entity,
      this.onSyncPressed});

  final GestureTapCallback? onTap;
  final DataFormSubmission entity;
  final String form;
  final Function(String uid)? onSyncPressed;

  @override
  SubmissionSummaryState createState() => SubmissionSummaryState();
}

class SubmissionSummaryState extends ConsumerState<SubmissionSummary> {
  Future<void> _confirmDelete(BuildContext context, String? uid) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.of(context).confirm),
          content: Text(
            S.of(context).conformDeleteMsg,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(S.of(context).cancel),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text(S.of(context).confirm),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      _showUndoSnackBar(context, uid);
    }
  }

  void _showUndoSnackBar(BuildContext context, String? toDeleteUid) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    ref
        .read(formSubmissionListProvider(form: widget.form).notifier)
        .deleteSubmission([toDeleteUid]);

    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text(S.of(context).itemRemoved), // Localized: "Item removed"
        action: SnackBarAction(
          label: S.of(context).undo, // Localized: "Undo"
          onPressed: () {
            // Code to undo deletion
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<SubmissionItemSummaryModel> submissionSummaryModelValue =
        ref.watch(submissionItemSummaryModelProvider(
            submissionUid: widget.entity.uid!, form: widget.form));
    return switch (submissionSummaryModelValue) {
      AsyncValue(error: final error?, stackTrace: final stackTrace) =>
        getErrorWidget(error, stackTrace),
      AsyncValue(valueOrNull: final submissionSummary?) => ListTile(
          isThreeLine: true,
          leading: Column(
            children: [
              buildStatusIcon(submissionSummary.syncStatus),
              Text(
                'V: ${widget.entity.version}',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: Theme.of(context).textTheme.bodySmall?.fontSize),
              )
            ],
          ),
          title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(submissionSummary.orgUnit),
                IconButton(
                    onPressed: () => _confirmDelete(context, widget.entity.uid),
                    icon: Icon(Icons.delete)),
              ]),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (submissionSummary.code != null)
                Text(submissionSummary.code!,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize:
                            Theme.of(context).textTheme.bodySmall?.fontSize)),
              Divider(),
              Text(generateFormSummary(submissionSummary.formData.unlock),
                  style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
          trailing: Column(
            children: [
              QSyncIconButton(
                state: submissionSummary.syncStatus,
                onUnsyncedPressed: () =>
                    widget.onSyncPressed?.call(widget.entity.uid!),
                // onUnsyncedPressed: () =>
                //     _showSyncDialog(<String>[widget.entity.uid!]),
              ),
            ],
          ),
          onTap: () {
            widget.onTap?.call();
          },
        ),
      _ => const SizedBox.shrink(),
    };
  }
}

String generateFormSummary(Map<String, dynamic> fields, [int itemsToTake = 5]) {
  final String fieldSummary = fields.entries
      .where((MapEntry<String, dynamic> entry) =>
          entry.key != 'name' &&
          entry.value != null &&
          !(entry.value is List) &&
          !syncableVariable.contains(entry.key))
      .take(itemsToTake)
      .map((MapEntry<String, dynamic> entry) => '${entry.key}: ${entry.value}')
      .join(', ');

  return fieldSummary.isNotEmpty ? fieldSummary : 'No additional data';
}

final List<String> syncableVariable = <String>[
  'id',
  'lastSyncMessage',
  'uid',
  'code',
  'name',
  'orgUnit',
  'createdDate',
  'lastModifiedDate',
  'deleted',
  'synced',
  'syncFailed',
  'lastSyncSummary',
  'lastSyncDate',
  'startEntryTime',
  'finishedEntryTime',
  'activity',
  'team',
  'status',
  'geometry',
  'dirty',
  'version',
  'form',
  'formData',
];
