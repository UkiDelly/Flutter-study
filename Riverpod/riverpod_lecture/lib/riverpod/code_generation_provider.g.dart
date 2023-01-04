// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'code_generation_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// ignore_for_file: avoid_private_typedef_functions, non_constant_identifier_names, subtype_of_sealed_class, invalid_use_of_internal_member, unused_element, constant_identifier_names, unnecessary_raw_strings, library_private_types_in_public_api

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

String _$getStateHash() => r'87bd84b095846bb6314eb8f2eb7f6659976faf89';

/// See also [getState].
final getStateProvider = AutoDisposeProvider<String>(
  getState,
  name: r'getStateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getStateHash,
);
typedef GetStateRef = AutoDisposeProviderRef<String>;
String _$getStateFutureHash() => r'cdeb1d5ae22168c97dc4e41ed70df1f5a7611d79';

/// See also [getStateFuture].
final getStateFutureProvider = AutoDisposeFutureProvider<int>(
  getStateFuture,
  name: r'getStateFutureProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getStateFutureHash,
);
typedef GetStateFutureRef = AutoDisposeFutureProviderRef<int>;
String _$getStateFuture2Hash() => r'e78f0cb83684efea2c9d80506056c9a5758186b4';

/// See also [getStateFuture2].
final getStateFuture2Provider = FutureProvider<int>(
  getStateFuture2,
  name: r'getStateFuture2Provider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getStateFuture2Hash,
);
typedef GetStateFuture2Ref = FutureProviderRef<int>;
String _$getStateMultiplyHash() => r'8d75c88cd2737f5dd50553871829689541b3cac5';

/// See also [getStateMultiply].
class GetStateMultiplyProvider extends AutoDisposeProvider<int> {
  GetStateMultiplyProvider({
    required this.number1,
    required this.number2,
  }) : super(
          (ref) => getStateMultiply(
            ref,
            number1: number1,
            number2: number2,
          ),
          from: getStateMultiplyProvider,
          name: r'getStateMultiplyProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getStateMultiplyHash,
        );

  final int number1;
  final int number2;

  @override
  bool operator ==(Object other) {
    return other is GetStateMultiplyProvider &&
        other.number1 == number1 &&
        other.number2 == number2;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, number1.hashCode);
    hash = _SystemHash.combine(hash, number2.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef GetStateMultiplyRef = AutoDisposeProviderRef<int>;

/// See also [getStateMultiply].
final getStateMultiplyProvider = GetStateMultiplyFamily();

class GetStateMultiplyFamily extends Family<int> {
  GetStateMultiplyFamily();

  GetStateMultiplyProvider call({
    required int number1,
    required int number2,
  }) {
    return GetStateMultiplyProvider(
      number1: number1,
      number2: number2,
    );
  }

  @override
  AutoDisposeProvider<int> getProviderOverride(
    covariant GetStateMultiplyProvider provider,
  ) {
    return call(
      number1: provider.number1,
      number2: provider.number2,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'getStateMultiplyProvider';
}
