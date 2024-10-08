// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submission_creation_model.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$submissionCreationModelHash() =>
    r'0ef4ed62a8d845c1ab3f2d7e15351e7c3dabbb79';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [submissionCreationModel].
@ProviderFor(submissionCreationModel)
const submissionCreationModelProvider = SubmissionCreationModelFamily();

/// See also [submissionCreationModel].
class SubmissionCreationModelFamily
    extends Family<AsyncValue<SubmissionCreationModel>> {
  /// See also [submissionCreationModel].
  const SubmissionCreationModelFamily();

  /// See also [submissionCreationModel].
  SubmissionCreationModelProvider call({
    required FormMetadata formMetaData,
  }) {
    return SubmissionCreationModelProvider(
      formMetaData: formMetaData,
    );
  }

  @override
  SubmissionCreationModelProvider getProviderOverride(
    covariant SubmissionCreationModelProvider provider,
  ) {
    return call(
      formMetaData: provider.formMetaData,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'submissionCreationModelProvider';
}

/// See also [submissionCreationModel].
class SubmissionCreationModelProvider
    extends AutoDisposeFutureProvider<SubmissionCreationModel> {
  /// See also [submissionCreationModel].
  SubmissionCreationModelProvider({
    required FormMetadata formMetaData,
  }) : this._internal(
          (ref) => submissionCreationModel(
            ref as SubmissionCreationModelRef,
            formMetaData: formMetaData,
          ),
          from: submissionCreationModelProvider,
          name: r'submissionCreationModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$submissionCreationModelHash,
          dependencies: SubmissionCreationModelFamily._dependencies,
          allTransitiveDependencies:
              SubmissionCreationModelFamily._allTransitiveDependencies,
          formMetaData: formMetaData,
        );

  SubmissionCreationModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.formMetaData,
  }) : super.internal();

  final FormMetadata formMetaData;

  @override
  Override overrideWith(
    FutureOr<SubmissionCreationModel> Function(
            SubmissionCreationModelRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SubmissionCreationModelProvider._internal(
        (ref) => create(ref as SubmissionCreationModelRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        formMetaData: formMetaData,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<SubmissionCreationModel> createElement() {
    return _SubmissionCreationModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SubmissionCreationModelProvider &&
        other.formMetaData == formMetaData;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, formMetaData.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SubmissionCreationModelRef
    on AutoDisposeFutureProviderRef<SubmissionCreationModel> {
  /// The parameter `formMetaData` of this provider.
  FormMetadata get formMetaData;
}

class _SubmissionCreationModelProviderElement
    extends AutoDisposeFutureProviderElement<SubmissionCreationModel>
    with SubmissionCreationModelRef {
  _SubmissionCreationModelProviderElement(super.provider);

  @override
  FormMetadata get formMetaData =>
      (origin as SubmissionCreationModelProvider).formMetaData;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
