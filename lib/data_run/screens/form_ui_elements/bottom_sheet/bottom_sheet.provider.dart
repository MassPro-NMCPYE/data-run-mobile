import 'package:flutter/material.dart';
import 'package:mass_pro/core/common/state.dart';
import 'package:mass_pro/data_run/screens/form_ui_elements/bottom_sheet/q_bottom_sheet_dialog_ui_model.dart';
import 'package:mass_pro/generated/l10n.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bottom_sheet.provider.g.dart';

@riverpod
QBottomSheetProvider bottomSheet(BottomSheetRef ref) {
  return QBottomSheetProvider();
}

class QBottomSheetProvider {
  QBottomSheetDialogUiModel formFinishBottomSheet() {
    return QBottomSheetDialogUiModel(
      title: S.current.finalData,
      subtitle: S.current.markAsFinalData,
      iconResource: Icons.info,
      mainButton: QDialogButtonStyle.completeButton(),
      secondaryButton:
          QDialogButtonStyle.neutralButton(textResource: S.current.notNow),
    );
  }

  QBottomSheetDialogUiModel syncBottomSheet(SyncStatus status) {
    return QBottomSheetDialogUiModel(
      title: 'Send to Server',
      subtitle: 'After Sending, Item will no longer be editable.',
      iconResource: Icons.info,
      mainButton: QDialogButtonStyle.mainButton(
        textResource: S.current.send,
        backgroundColor: Colors.blueAccent,
        colorResource: Colors.white,
        iconResource: Icons.sync,
      ),
      secondaryButton:
          QDialogButtonStyle.neutralButton(textResource: S.current.notNow),
    );
  }
}
