import 'package:equatable/equatable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../commons/helpers/collections.dart';
part 'program_event_detail_view_model.g.dart';

@riverpod
class ProgramEventDetailViewModel extends _$ProgramEventDetailViewModel {
  @override
  ProgramEventDetailModel build() {
    return ProgramEventDetailModel();
  }

  void setProgress(bool showProgress) {
    state = state.copyWith(progress: showProgress);
  }

  void showList() {
    state = state.copyWith(currentScreen: EventProgramScreen.LIST);
  }

  void showMap() {
    state = state.copyWith(currentScreen: EventProgramScreen.MAP);
  }

  void showAnalytics() {
    state = state.copyWith(currentScreen: EventProgramScreen.ANALYTICS);
  }

  void onRecreationActivity(bool isRecreating) {
    state = state.copyWith(recreationActivity: isRecreating);
  }

  void updateBackdrop(bool isActive) {
    state = state.copyWith(backdropActive: isActive);
  }
}

enum EventProgramScreen {
  LIST,
  // NMC
  TABLE,
  MAP,
  ANALYTICS,
}

class ProgramEventDetailModel with EquatableMixin {
  ProgramEventDetailModel(
      {this.progress = true,
      this.writePermission = false,
      this.eventSyncClicked,
      this.eventClicked,
      this.updateEvent,
      this.programName,
      this.recreationActivity = false,
      this.currentScreen = EventProgramScreen.LIST,
      this.backdropActive = false});

  final bool progress;
  final bool writePermission;
  final String? eventSyncClicked;
  final Pair<String, String>? eventClicked;
  final String? updateEvent;
  final bool recreationActivity;

  final EventProgramScreen currentScreen;

  final bool backdropActive;

  /// NMC
  final String? programName;

  ProgramEventDetailModel copyWith({
    final bool? progress,
    final bool? writePermission,
    final String? eventSyncClicked,
    final Pair<String, String>? eventClicked,
    final String? updateEvent,
    final String? programName,
    bool? recreationActivity,
    EventProgramScreen? currentScreen,
    bool? backdropActive,
  }) =>
      ProgramEventDetailModel(
          progress: progress ?? this.progress,
          writePermission: writePermission ?? this.writePermission,
          eventSyncClicked: eventSyncClicked,
          eventClicked: eventClicked,
          updateEvent: updateEvent,
          programName: programName ?? this.programName,
          recreationActivity: recreationActivity ?? this.recreationActivity,
          currentScreen: currentScreen ?? this.currentScreen,
          backdropActive: backdropActive ?? this.backdropActive);

  @override
  List<Object?> get props => [
        progress,
        writePermission,
        eventSyncClicked,
        eventClicked,
        updateEvent,
        programName,
        recreationActivity,
        currentScreen,
        backdropActive
      ];
}
