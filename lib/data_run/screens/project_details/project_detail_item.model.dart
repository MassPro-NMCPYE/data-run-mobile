import 'package:equatable/equatable.dart';
import 'package:mass_pro/commons/ui/metadata_icon_data.dart';
import 'package:mass_pro/core/common/state.dart';

class FormListItemModel with EquatableMixin {
  FormListItemModel(
      {
      /// form uid
      required this.form,
      required this.formCode,
      this.formName,
      this.activity,
      this.entitiesToPost = 0,
      this.entitiesToUpdate = 0,
      this.entitiesSynced = 0,
      this.entitiesWithError = 0,
      this.canAddNewEvent = true,
      this.description,
      required this.state});

  final String form;
  final String formCode;
  final String? formName;
  final String? activity;
  final String? description;
  final int entitiesToPost;
  final int entitiesToUpdate;
  final int entitiesSynced;
  final int entitiesWithError;
  final bool canAddNewEvent;
  final SyncableEntityState state;

  FormListItemModel copyWith(
          {String? form,
          String? formCode,
          String? formName,
          String? activity,
          String? description,
          int? entitiesToPost,
          int? entitiesToUpdate,
          int? entitiesSynced,
          int? entitiesWithError,
          bool? canAddNewEvent,
          SyncableEntityState? state}) =>
      FormListItemModel(
        form: form ?? this.form,
        formCode: formCode ?? this.formCode,
        formName: formName ?? this.formName,
        activity: activity ?? this.activity,
        description: description ?? this.description,
        entitiesToPost: entitiesToPost ?? this.entitiesToPost,
        entitiesToUpdate: entitiesToUpdate ?? this.entitiesToUpdate,
        entitiesSynced: entitiesSynced ?? this.entitiesSynced,
        entitiesWithError: entitiesWithError ?? this.entitiesWithError,
        canAddNewEvent: canAddNewEvent ?? this.canAddNewEvent,
        state: state ?? this.state,
      );

  @override
  List<Object?> get props => [
        form,
        formCode,
        formName,
        activity,
        entitiesToPost,
        entitiesToUpdate,
        entitiesSynced,
        entitiesWithError,
        canAddNewEvent,
        description,
        state
      ];
}

class ProjectDetailItemModel with EquatableMixin {
  ProjectDetailItemModel(
      {
      /// activity uid
      required this.activity,
      required this.activityName,
      // this.team,
      this.activeFormCount = 0,
      this.isSelected = false,
      this.valueListIsOpen = true,
      this.metadataIconData,
      this.description,
      required this.state});

  final String activity;
  final String activityName;

  // final String? team;

  final int activeFormCount;
  final String? description;

  final bool isSelected;
  final bool valueListIsOpen;
  final MetadataIconData? metadataIconData;
  final SyncableEntityState state;

  ProjectDetailItemModel copyWith(
          {String? activity,
          String? activityName,
          // String? team,
          int? activeFormCount,
          bool? isSelected,
          bool? valueListIsOpen,
          MetadataIconData? metadataIconData,
          String? description,
          SyncableEntityState? state}) =>
      ProjectDetailItemModel(
          activity: activity ?? this.activity,
          activityName: activityName ?? this.activityName,
          // team: team ?? this.team,
          metadataIconData: metadataIconData ?? this.metadataIconData,
          activeFormCount: activeFormCount ?? this.activeFormCount,
          state: state ?? this.state,
          description: description ?? this.description,
          isSelected: isSelected ?? this.isSelected,
          valueListIsOpen: valueListIsOpen ?? this.valueListIsOpen);

  @override
  List<Object?> get props => [
        activity,
        activityName,
        // team,
        activeFormCount,
        description,
        isSelected,
        valueListIsOpen,
        metadataIconData,
        activeFormCount,
        state,
        description,
      ];
}
