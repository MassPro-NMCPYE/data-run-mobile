import 'package:d2_remote/d2_remote.dart';
import 'package:d2_remote/modules/metadatarun/activity/entities/d_activity.entity.dart';
import 'package:d2_remote/modules/datarun/common/standard_extensions.dart';
import 'package:mass_pro/core/common/state.dart';
import 'package:mass_pro/data_run/repository/project_activity_repository/project_activity_repository.dart';

class ProjectActivityChvRepository with ProjectActivityRepository<DActivity> {
  ProjectActivityChvRepository();

  @override
  Future<int> getCount([String? id]) async {
    final data = await get();
    return data.length;
  }

  @override
  Future<SyncableEntityState> getState([String? id]) async {
    final withSyncErrorStateRegisters =
        await D2Remote.iccmModule.chvRegister.withSyncErrorState().count();
    final withUpdateErrorStateRegisters = await D2Remote.iccmModule.chvRegister
        .withUpdateSyncedErrorState()
        .count();

    final withSyncErrorStateSessions =
        await D2Remote.iccmModule.chvSession.withSyncErrorState().count();
    final withUpdateErrorStateSessions = await D2Remote.iccmModule.chvSession
        .withUpdateSyncedErrorState()
        .count();

    final withSyncErrorState =
        withSyncErrorStateRegisters > 0 || withUpdateErrorStateRegisters > 0;
    final withUpdateErrorState =
        withSyncErrorStateSessions > 0 || withUpdateErrorStateSessions > 0;

    final withToPostStateRegisters =
        await D2Remote.iccmModule.chvRegister.withToPostState().count();
    final withToUpdateStateRegisters =
        await D2Remote.iccmModule.chvRegister.withToUpdateState().count();

    final withToPostStateSessions =
        await D2Remote.iccmModule.chvSession.withToPostState().count();
    final withToUpdateStateSessions =
        await D2Remote.iccmModule.chvSession.withToUpdateState().count();

    final withToPostState =
        withToPostStateRegisters > 0 || withToPostStateSessions > 0;
    final withToUpdateState =
        withToUpdateStateRegisters > 0 || withToUpdateStateSessions > 0;

    return when(true, {
      withUpdateErrorState || withSyncErrorState: () => SyncableEntityState.WARNING,
      withToPostState: () => SyncableEntityState.TO_POST,
      withToUpdateState: () => SyncableEntityState.TO_UPDATE,
    }).orElse(() => SyncableEntityState.SYNCED);
  }
}
