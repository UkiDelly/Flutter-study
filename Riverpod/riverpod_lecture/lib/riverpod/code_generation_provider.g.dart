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
