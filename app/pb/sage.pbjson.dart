//
//  Generated code. Do not modify.
//  source: sage.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use genderDescriptor instead')
const Gender$json = {
  '1': 'Gender',
  '2': [
    {'1': 'MAN', '2': 0},
    {'1': 'WOMAN', '2': 1},
    {'1': 'HUMAN', '2': 2},
  ],
};

/// Descriptor for `Gender`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List genderDescriptor = $convert.base64Decode(
    'CgZHZW5kZXISBwoDTUFOEAASCQoFV09NQU4QARIJCgVIVU1BThAC');

@$core.Deprecated('Use proximityDescriptor instead')
const Proximity$json = {
  '1': 'Proximity',
  '2': [
    {'1': 'HOOD', '2': 0},
    {'1': 'CITY', '2': 1},
    {'1': 'METRO', '2': 2},
    {'1': 'STATE', '2': 3},
    {'1': 'COUNTRY', '2': 4},
  ],
};

/// Descriptor for `Proximity`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List proximityDescriptor = $convert.base64Decode(
    'CglQcm94aW1pdHkSCAoESE9PRBAAEggKBENJVFkQARIJCgVNRVRSTxACEgkKBVNUQVRFEAMSCw'
    'oHQ09VTlRSWRAE');

@$core.Deprecated('Use tokenDescriptor instead')
const Token$json = {
  '1': 'Token',
  '2': [
    {'1': 'id_token', '3': 1, '4': 1, '5': 9, '10': 'idToken'},
    {'1': 'access_token', '3': 2, '4': 1, '5': 9, '10': 'accessToken'},
    {'1': 'refresh_token', '3': 3, '4': 1, '5': 9, '10': 'refreshToken'},
  ],
};

/// Descriptor for `Token`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tokenDescriptor = $convert.base64Decode(
    'CgVUb2tlbhIZCghpZF90b2tlbhgBIAEoCVIHaWRUb2tlbhIhCgxhY2Nlc3NfdG9rZW4YAiABKA'
    'lSC2FjY2Vzc1Rva2VuEiMKDXJlZnJlc2hfdG9rZW4YAyABKAlSDHJlZnJlc2hUb2tlbg==');

@$core.Deprecated('Use userDescriptor instead')
const User$json = {
  '1': 'User',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'email', '3': 3, '4': 1, '5': 9, '10': 'email'},
    {'1': 'rating', '3': 4, '4': 1, '5': 1, '10': 'rating'},
    {'1': 'gender', '3': 5, '4': 1, '5': 14, '6': '.Gender', '10': 'gender'},
    {'1': 'birthday', '3': 6, '4': 1, '5': 5, '10': 'birthday'},
    {'1': 'video_url', '3': 7, '4': 1, '5': 9, '10': 'videoUrl'},
    {'1': 'location', '3': 8, '4': 1, '5': 11, '6': '.Location', '10': 'location'},
    {'1': 'preferences', '3': 9, '4': 1, '5': 11, '6': '.Preferences', '10': 'preferences'},
  ],
};

/// Descriptor for `User`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDescriptor = $convert.base64Decode(
    'CgRVc2VyEg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEhQKBWVtYWlsGAMgAS'
    'gJUgVlbWFpbBIWCgZyYXRpbmcYBCABKAFSBnJhdGluZxIfCgZnZW5kZXIYBSABKA4yBy5HZW5k'
    'ZXJSBmdlbmRlchIaCghiaXJ0aGRheRgGIAEoBVIIYmlydGhkYXkSGwoJdmlkZW9fdXJsGAcgAS'
    'gJUgh2aWRlb1VybBIlCghsb2NhdGlvbhgIIAEoCzIJLkxvY2F0aW9uUghsb2NhdGlvbhIuCgtw'
    'cmVmZXJlbmNlcxgJIAEoCzIMLlByZWZlcmVuY2VzUgtwcmVmZXJlbmNlcw==');

@$core.Deprecated('Use createUserRequestDescriptor instead')
const CreateUserRequest$json = {
  '1': 'CreateUserRequest',
  '2': [
    {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.User', '10': 'user'},
  ],
};

/// Descriptor for `CreateUserRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createUserRequestDescriptor = $convert.base64Decode(
    'ChFDcmVhdGVVc2VyUmVxdWVzdBIZCgR1c2VyGAEgASgLMgUuVXNlclIEdXNlcg==');

@$core.Deprecated('Use createUserResponseDescriptor instead')
const CreateUserResponse$json = {
  '1': 'CreateUserResponse',
  '2': [
    {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.User', '10': 'user'},
  ],
};

/// Descriptor for `CreateUserResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createUserResponseDescriptor = $convert.base64Decode(
    'ChJDcmVhdGVVc2VyUmVzcG9uc2USGQoEdXNlchgBIAEoCzIFLlVzZXJSBHVzZXI=');

@$core.Deprecated('Use locationDescriptor instead')
const Location$json = {
  '1': 'Location',
  '2': [
    {'1': 'lat', '3': 1, '4': 1, '5': 5, '10': 'lat'},
    {'1': 'long', '3': 2, '4': 1, '5': 5, '10': 'long'},
  ],
};

/// Descriptor for `Location`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List locationDescriptor = $convert.base64Decode(
    'CghMb2NhdGlvbhIQCgNsYXQYASABKAVSA2xhdBISCgRsb25nGAIgASgFUgRsb25n');

@$core.Deprecated('Use preferencesDescriptor instead')
const Preferences$json = {
  '1': 'Preferences',
  '2': [
    {'1': 'age_min', '3': 1, '4': 1, '5': 5, '10': 'ageMin'},
    {'1': 'age_max', '3': 2, '4': 1, '5': 5, '10': 'ageMax'},
    {'1': 'proximity', '3': 3, '4': 1, '5': 14, '6': '.Proximity', '10': 'proximity'},
    {'1': 'gender', '3': 4, '4': 3, '5': 14, '6': '.Gender', '10': 'gender'},
  ],
};

/// Descriptor for `Preferences`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List preferencesDescriptor = $convert.base64Decode(
    'CgtQcmVmZXJlbmNlcxIXCgdhZ2VfbWluGAEgASgFUgZhZ2VNaW4SFwoHYWdlX21heBgCIAEoBV'
    'IGYWdlTWF4EigKCXByb3hpbWl0eRgDIAEoDjIKLlByb3hpbWl0eVIJcHJveGltaXR5Eh8KBmdl'
    'bmRlchgEIAMoDjIHLkdlbmRlclIGZ2VuZGVy');

@$core.Deprecated('Use sDPDescriptor instead')
const SDP$json = {
  '1': 'SDP',
  '2': [
    {'1': 'type', '3': 1, '4': 1, '5': 5, '10': 'type'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
  ],
};

/// Descriptor for `SDP`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sDPDescriptor = $convert.base64Decode(
    'CgNTRFASEgoEdHlwZRgBIAEoBVIEdHlwZRIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdlEiAKC2'
    'Rlc2NyaXB0aW9uGAMgASgJUgtkZXNjcmlwdGlvbg==');

@$core.Deprecated('Use iCEDescriptor instead')
const ICE$json = {
  '1': 'ICE',
  '2': [
    {'1': 'sdp', '3': 1, '4': 1, '5': 11, '6': '.SDP', '10': 'sdp'},
    {'1': 'stream_id', '3': 2, '4': 1, '5': 9, '10': 'streamId'},
    {'1': 'line_index', '3': 3, '4': 1, '5': 5, '10': 'lineIndex'},
    {'1': 'server_url', '3': 4, '4': 1, '5': 9, '10': 'serverUrl'},
  ],
};

/// Descriptor for `ICE`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List iCEDescriptor = $convert.base64Decode(
    'CgNJQ0USFgoDc2RwGAEgASgLMgQuU0RQUgNzZHASGwoJc3RyZWFtX2lkGAIgASgJUghzdHJlYW'
    '1JZBIdCgpsaW5lX2luZGV4GAMgASgFUglsaW5lSW5kZXgSHQoKc2VydmVyX3VybBgEIAEoCVIJ'
    'c2VydmVyVXJs');

@$core.Deprecated('Use signalingRequestDescriptor instead')
const SignalingRequest$json = {
  '1': 'SignalingRequest',
  '2': [
    {'1': 'sdp', '3': 1, '4': 1, '5': 11, '6': '.SDP', '9': 0, '10': 'sdp'},
    {'1': 'ice', '3': 2, '4': 1, '5': 11, '6': '.ICE', '9': 0, '10': 'ice'},
  ],
  '8': [
    {'1': 'message'},
  ],
};

/// Descriptor for `SignalingRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signalingRequestDescriptor = $convert.base64Decode(
    'ChBTaWduYWxpbmdSZXF1ZXN0EhgKA3NkcBgBIAEoCzIELlNEUEgAUgNzZHASGAoDaWNlGAIgAS'
    'gLMgQuSUNFSABSA2ljZUIJCgdtZXNzYWdl');

@$core.Deprecated('Use presignedURLRequestDescriptor instead')
const PresignedURLRequest$json = {
  '1': 'PresignedURLRequest',
  '2': [
    {'1': 'action', '3': 1, '4': 1, '5': 9, '10': 'action'},
    {'1': 'file_name', '3': 2, '4': 1, '5': 9, '10': 'fileName'},
  ],
};

/// Descriptor for `PresignedURLRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List presignedURLRequestDescriptor = $convert.base64Decode(
    'ChNQcmVzaWduZWRVUkxSZXF1ZXN0EhYKBmFjdGlvbhgBIAEoCVIGYWN0aW9uEhsKCWZpbGVfbm'
    'FtZRgCIAEoCVIIZmlsZU5hbWU=');

@$core.Deprecated('Use presignedURLResponseDescriptor instead')
const PresignedURLResponse$json = {
  '1': 'PresignedURLResponse',
  '2': [
    {'1': 'url', '3': 1, '4': 1, '5': 9, '10': 'url'},
    {'1': 'request', '3': 2, '4': 1, '5': 11, '6': '.PresignedURLRequest', '10': 'request'},
  ],
};

/// Descriptor for `PresignedURLResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List presignedURLResponseDescriptor = $convert.base64Decode(
    'ChRQcmVzaWduZWRVUkxSZXNwb25zZRIQCgN1cmwYASABKAlSA3VybBIuCgdyZXF1ZXN0GAIgAS'
    'gLMhQuUHJlc2lnbmVkVVJMUmVxdWVzdFIHcmVxdWVzdA==');

