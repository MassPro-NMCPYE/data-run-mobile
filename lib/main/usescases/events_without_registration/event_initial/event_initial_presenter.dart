import 'package:d2_remote/modules/data/tracker/models/geometry.dart';
import 'package:d2_remote/modules/metadata/program/entities/program.entity.dart';
import 'package:d2_remote/modules/metadata/program/entities/program_stage.entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../commons/constants.dart';
import '../../../../commons/extensions/string_extension.dart';
import '../../../../commons/helpers/collections.dart';
import '../../../../commons/prefs/preference.dart';
import '../../../../core/event/event_editable_status.dart';
import '../../../../form/data/form_section_view_model.dart';
import '../../../../form/di/injector.dart';
import '../../../../form/model/field_ui_model.dart';
import '../../../../form/ui/form_view_model.dart';
import '../../../../main.dart';
import '../../../l10n/app_localizations.dart';
import '../../bundle/bundle.dart';
import '../event_capture/event_section_model.dart';
import 'di/event_initial_module.dart';
import 'event_initial_repository.dart';
import 'event_initial_view_base.dart';
import 'di/presenter_providers.dart';

class EventInitialPresenter {
  EventInitialPresenter(this.ref, this.view, this.eventInitialRepository) {
    _init();
  }
  final EventInitialPresenterRef ref;
  // final PreferenceProvider preferences;
  //  final AnalyticsHelper analyticsHelper;

  final EventInitialRepository eventInitialRepository;

  //  final RulesUtilsProvider ruleUtils;
  final EventInitialViewBase view;

  //  final SchedulerProvider schedulerProvider;
  // final EventFieldMapper eventFieldMapper;

  String? eventId;

  Program? program;

  String? programStageId;
  late final Bundle eventBundle;

  Future<void> _init() async {
    eventBundle = ref.read(bundleObjectProvider);

    eventId = eventBundle.getString(EVENT_UID);
    programStageId = eventBundle.getString(PROGRAM_STAGE_UID);

    // view.setAccessDataWrite(
    //             eventInitialRepository.accessDataWrite(programId).blockingFirst()
    //     );
    if (eventId != null) {
      final program = await eventInitialRepository
          .getProgramWithId(eventBundle.getString(PROGRAM_UID));
      final programStage =
          await eventInitialRepository.programStageForEvent(eventId!);
      this.program = program;
      view.setProgram(program);
    } else {
      eventInitialRepository
          .getProgramWithId(eventBundle.getString(PROGRAM_UID))
          .then((Program? program) {
        this.program = program;
        view.setProgram(program);
      });

      _getProgramStages(eventBundle.getString(PROGRAM_UID)!,
          eventBundle.getString(PROGRAM_STAGE_UID));
    }

    if (eventId != null) {
      _getSectionCompletion();
    }
  }

  String getCurrentOrgUnit(String orgUnitUid) {
    if (ref.read(preferencesInstanceProvider).contains([CURRENT_ORG_UNIT])) {
      return ref.read(preferencesInstanceProvider).getString(CURRENT_ORG_UNIT)!;
    } else {
      return orgUnitUid;
    }
  }

  void onShareClick() {
    // view.showQR();
  }

  void deleteEvent(String trackedEntityInstance) {
    final BuildContext context = navigatorKey.currentContext!;
    if (eventId != null) {
      eventInitialRepository.deleteEvent(eventId!, trackedEntityInstance);
      ref
          .read(showToastProvider.notifier)
          .setValue(AppLocalization.of(context)!.lookup('event_was_deleted'));
    } else {
      ref
          .read(showToastProvider.notifier)
          .setValue(AppLocalization.of(context)!.lookup('delete_event_error'));
    }
  }

  Future<bool> isEnrollmentOpen() {
    return eventInitialRepository.isEnrollmentOpen();
  }

  void getProgramStage(String programStageUid) {
    eventInitialRepository
        .programStageWithId(programStageUid)
        .then((programStage) => view.setProgramStage(programStage))
        .onError((error, stackTrace) {
      // view.showProgramStageSelection();
    });
    //   compositeDisposable.add(
    //           eventInitialRepository.programStageWithId(programStageUid)
    //                   .subscribeOn(schedulerProvider.io())
    //                   .observeOn(schedulerProvider.ui())
    //                   .subscribe(
    //                           programStage -> view.setProgramStage(programStage),
    //                           throwable -> view.showProgramStageSelection()
    //                   )
    //   );
  }

  Future<void> _getProgramStages(
      String programUid, String? programStageUid) async {
    Future<ProgramStage?> programStage;
    if (programStageId.isNullOrEmpty) {
      programStage = eventInitialRepository.programStage(programUid);
    } else {
      programStage = eventInitialRepository.programStageWithId(programStageUid);
    }
    programStage
        .then(
            (ProgramStage? programStage) => view.setProgramStage(programStage))
        .onError((error, stackTrace) {
      // view.showProgramStageSelection();
    });
  }

  void onBackClick() {
    view.back();
    // setChangingCoordinates(false);
    // if (eventId != null)
    //     analyticsHelper.setEvent(BACK_EVENT, CLICK, CREATE_EVENT);
    // view.back();
  }

  void createEvent(
      String enrollmentUid,
      String programStageModel,
      DateTime date,
      String activityUid,
      String orgUnitUid,
      Geometry geometry,
      String trackedEntityInstance) {
    if (program != null) {
      ref
          .read(preferencesInstanceProvider)
          .setValue(CURRENT_ORG_UNIT, orgUnitUid);
      eventInitialRepository
          .createEvent(enrollmentUid, trackedEntityInstance, program!.id!,
              programStageModel, date, orgUnitUid, activityUid, geometry)
          .then((String value) =>
              ref.read(onEventCreatedProvider.notifier).setValue(value))
          .onError((error, stackTrace) => ref
              .read(errorRenderProvider.notifier)
              .setValue(error.toString()));
    }
  }

  void scheduleEventPermanent(
      String enrollmentUid,
      String trackedEntityInstanceUid,
      String programStageModel,
      DateTime dueDate,
      String activityUid,
      String orgUnitUid,
      Geometry geometry) {
    if (program != null) {
      ref
          .read(preferencesInstanceProvider)
          .setValue(CURRENT_ORG_UNIT, orgUnitUid);
      eventInitialRepository
          .permanentReferral(
              enrollmentUid,
              trackedEntityInstanceUid,
              program!.id!,
              programStageModel,
              dueDate,
              orgUnitUid,
              activityUid,
              geometry)
          .then((String value) =>
              ref.read(onEventCreatedProvider.notifier).setValue(value))
          .onError((error, stackTrace) => ref
              .read(errorRenderProvider.notifier)
              .setValue(error.toString()));
    }
  }

  void scheduleEvent(
      String enrollmentUid,
      String programStageModel,
      DateTime dueDate,
      String orgUnitUid,
      String activityUid,
      Geometry geometry) {
    if (program != null) {
      ref
          .read(preferencesInstanceProvider)
          .setValue(CURRENT_ORG_UNIT, orgUnitUid);
      eventInitialRepository
          .scheduleEvent(enrollmentUid, null, program!.id!, programStageModel,
              dueDate, orgUnitUid, activityUid, geometry)
          .then((String value) =>
              ref.read(onEventCreatedProvider.notifier).setValue(value))
          .onError((error, stackTrace) => ref
              .read(errorRenderProvider.notifier)
              .setValue(error.toString()));
    }
  }

  void _getSectionCompletion() {
    final Future<List<FieldUiModel>> fieldsFlowable =
        eventInitialRepository.list();
    // Future<Result<RuleEffect>> ruleEffectFlowable = eventInitialRepository.calculate()
    //         .subscribeOn(schedulerProvider.computation())
    //         .onErrorReturn(throwable -> Result.failure(new Exception(throwable)));

    // Future<List<FieldUiModel>> viewModelsFlowable = Future.wait([fieldsFlowable, ruleEffectFlowable,
    //         this.applyEffects]);

    final Future<List<FieldUiModel>> viewModelsFuture = fieldsFlowable;
    eventInitialRepository.eventSections().then(
        (List<FormSectionViewModel> sectionList) {
      sectionList.map((item) => null);
      return viewModelsFuture.then((List<FieldUiModel> fields) {
        return ref.read(fieldMapperProvider).map(fields, sectionList, '', {},
            {}, {}, const Pair<bool, bool>(false, false));
      });
    }).then((Pair<List<EventSectionModel>, List<FieldUiModel>> value) => ref
        .read(percentageUpdaterProvider.notifier)
        .setValue(ref.read(fieldMapperProvider).completedFieldsPercentage()));
  }

  void setChangingCoordinates(bool changingCoordinates) {
    if (changingCoordinates) {
      ref
          .read(preferencesInstanceProvider)
          .setValue(EVENT_COORDINATE_CHANGED, true);
    } else {
      ref
          .read(preferencesInstanceProvider)
          .removeValue(EVENT_COORDINATE_CHANGED);
    }
  }

  bool getCompletionPercentageVisibility() {
    return eventInitialRepository.showCompletionPercentage();
  }

  void onEventCreated() {
    // matomoAnalyticsController.trackEvent(EVENT_LIST, CREATE_EVENT, CLICK);
  }

  Future<bool> isEventEditable() async {
    return (await eventInitialRepository.getEditableStatus()) is Editable;
  }
}
