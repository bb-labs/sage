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

@$core.Deprecated('Use genderPluralDescriptor instead')
const GenderPlural$json = {
  '1': 'GenderPlural',
  '2': [
    {'1': 'MEN', '2': 0},
    {'1': 'WOMEN', '2': 1},
    {'1': 'HUMANS', '2': 2},
  ],
};

/// Descriptor for `GenderPlural`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List genderPluralDescriptor = $convert.base64Decode(
    'CgxHZW5kZXJQbHVyYWwSBwoDTUVOEAASCQoFV09NRU4QARIKCgZIVU1BTlMQAg==');

@$core.Deprecated('Use presignActionDescriptor instead')
const PresignAction$json = {
  '1': 'PresignAction',
  '2': [
    {'1': 'GET', '2': 0},
    {'1': 'PUT', '2': 1},
    {'1': 'DELETE', '2': 2},
  ],
};

/// Descriptor for `PresignAction`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List presignActionDescriptor = $convert.base64Decode(
    'Cg1QcmVzaWduQWN0aW9uEgcKA0dFVBAAEgcKA1BVVBABEgoKBkRFTEVURRAC');

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
    {'1': 'gender', '3': 5, '4': 3, '5': 14, '6': '.Gender', '10': 'gender'},
    {'1': 'birthday', '3': 6, '4': 1, '5': 11, '6': '.Birthday', '10': 'birthday'},
    {'1': 'location', '3': 7, '4': 1, '5': 11, '6': '.Location', '10': 'location'},
    {'1': 'preferences', '3': 8, '4': 1, '5': 11, '6': '.Preferences', '10': 'preferences'},
  ],
};

/// Descriptor for `User`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDescriptor = $convert.base64Decode(
    'CgRVc2VyEg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEhQKBWVtYWlsGAMgAS'
    'gJUgVlbWFpbBIWCgZyYXRpbmcYBCABKAFSBnJhdGluZxIfCgZnZW5kZXIYBSADKA4yBy5HZW5k'
    'ZXJSBmdlbmRlchIlCghiaXJ0aGRheRgGIAEoCzIJLkJpcnRoZGF5UghiaXJ0aGRheRIlCghsb2'
    'NhdGlvbhgHIAEoCzIJLkxvY2F0aW9uUghsb2NhdGlvbhIuCgtwcmVmZXJlbmNlcxgIIAEoCzIM'
    'LlByZWZlcmVuY2VzUgtwcmVmZXJlbmNlcw==');

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

@$core.Deprecated('Use getUserRequestDescriptor instead')
const GetUserRequest$json = {
  '1': 'GetUserRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `GetUserRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserRequestDescriptor = $convert.base64Decode(
    'Cg5HZXRVc2VyUmVxdWVzdBIOCgJpZBgBIAEoCVICaWQ=');

@$core.Deprecated('Use getUserResponseDescriptor instead')
const GetUserResponse$json = {
  '1': 'GetUserResponse',
  '2': [
    {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.User', '10': 'user'},
  ],
};

/// Descriptor for `GetUserResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserResponseDescriptor = $convert.base64Decode(
    'Cg9HZXRVc2VyUmVzcG9uc2USGQoEdXNlchgBIAEoCzIFLlVzZXJSBHVzZXI=');

@$core.Deprecated('Use updateUserRequestDescriptor instead')
const UpdateUserRequest$json = {
  '1': 'UpdateUserRequest',
  '2': [
    {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.User', '10': 'user'},
  ],
};

/// Descriptor for `UpdateUserRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateUserRequestDescriptor = $convert.base64Decode(
    'ChFVcGRhdGVVc2VyUmVxdWVzdBIZCgR1c2VyGAEgASgLMgUuVXNlclIEdXNlcg==');

@$core.Deprecated('Use updateUserResponseDescriptor instead')
const UpdateUserResponse$json = {
  '1': 'UpdateUserResponse',
};

/// Descriptor for `UpdateUserResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateUserResponseDescriptor = $convert.base64Decode(
    'ChJVcGRhdGVVc2VyUmVzcG9uc2U=');

@$core.Deprecated('Use regionDescriptor instead')
const Region$json = {
  '1': 'Region',
  '2': [
    {'1': 'northeast', '3': 1, '4': 1, '5': 11, '6': '.Location', '10': 'northeast'},
    {'1': 'southwest', '3': 2, '4': 1, '5': 11, '6': '.Location', '10': 'southwest'},
  ],
};

/// Descriptor for `Region`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List regionDescriptor = $convert.base64Decode(
    'CgZSZWdpb24SJwoJbm9ydGhlYXN0GAEgASgLMgkuTG9jYXRpb25SCW5vcnRoZWFzdBInCglzb3'
    'V0aHdlc3QYAiABKAsyCS5Mb2NhdGlvblIJc291dGh3ZXN0');

@$core.Deprecated('Use locationDescriptor instead')
const Location$json = {
  '1': 'Location',
  '2': [
    {'1': 'latitude', '3': 1, '4': 1, '5': 1, '10': 'latitude'},
    {'1': 'longitude', '3': 2, '4': 1, '5': 1, '10': 'longitude'},
  ],
};

/// Descriptor for `Location`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List locationDescriptor = $convert.base64Decode(
    'CghMb2NhdGlvbhIaCghsYXRpdHVkZRgBIAEoAVIIbGF0aXR1ZGUSHAoJbG9uZ2l0dWRlGAIgAS'
    'gBUglsb25naXR1ZGU=');

@$core.Deprecated('Use birthdayDescriptor instead')
const Birthday$json = {
  '1': 'Birthday',
  '2': [
    {'1': 'day', '3': 1, '4': 1, '5': 5, '10': 'day'},
    {'1': 'month', '3': 2, '4': 1, '5': 5, '10': 'month'},
    {'1': 'year', '3': 3, '4': 1, '5': 5, '10': 'year'},
  ],
};

/// Descriptor for `Birthday`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List birthdayDescriptor = $convert.base64Decode(
    'CghCaXJ0aGRheRIQCgNkYXkYASABKAVSA2RheRIUCgVtb250aBgCIAEoBVIFbW9udGgSEgoEeW'
    'VhchgDIAEoBVIEeWVhcg==');

@$core.Deprecated('Use preferencesDescriptor instead')
const Preferences$json = {
  '1': 'Preferences',
  '2': [
    {'1': 'age_min', '3': 1, '4': 1, '5': 5, '10': 'ageMin'},
    {'1': 'age_max', '3': 2, '4': 1, '5': 5, '10': 'ageMax'},
    {'1': 'region', '3': 3, '4': 1, '5': 11, '6': '.Region', '10': 'region'},
    {'1': 'gender', '3': 4, '4': 3, '5': 14, '6': '.Gender', '10': 'gender'},
  ],
};

/// Descriptor for `Preferences`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List preferencesDescriptor = $convert.base64Decode(
    'CgtQcmVmZXJlbmNlcxIXCgdhZ2VfbWluGAEgASgFUgZhZ2VNaW4SFwoHYWdlX21heBgCIAEoBV'
    'IGYWdlTWF4Eh8KBnJlZ2lvbhgDIAEoCzIHLlJlZ2lvblIGcmVnaW9uEh8KBmdlbmRlchgEIAMo'
    'DjIHLkdlbmRlclIGZ2VuZGVy');

@$core.Deprecated('Use createPresignedURLRequestDescriptor instead')
const CreatePresignedURLRequest$json = {
  '1': 'CreatePresignedURLRequest',
  '2': [
    {'1': 'action', '3': 1, '4': 1, '5': 14, '6': '.PresignAction', '10': 'action'},
    {'1': 'file_name', '3': 2, '4': 1, '5': 9, '10': 'fileName'},
    {'1': 'mime_type', '3': 3, '4': 1, '5': 9, '10': 'mimeType'},
  ],
};

/// Descriptor for `CreatePresignedURLRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createPresignedURLRequestDescriptor = $convert.base64Decode(
    'ChlDcmVhdGVQcmVzaWduZWRVUkxSZXF1ZXN0EiYKBmFjdGlvbhgBIAEoDjIOLlByZXNpZ25BY3'
    'Rpb25SBmFjdGlvbhIbCglmaWxlX25hbWUYAiABKAlSCGZpbGVOYW1lEhsKCW1pbWVfdHlwZRgD'
    'IAEoCVIIbWltZVR5cGU=');

@$core.Deprecated('Use createPresignedURLResponseDescriptor instead')
const CreatePresignedURLResponse$json = {
  '1': 'CreatePresignedURLResponse',
  '2': [
    {'1': 'url', '3': 1, '4': 1, '5': 9, '10': 'url'},
  ],
};

/// Descriptor for `CreatePresignedURLResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createPresignedURLResponseDescriptor = $convert.base64Decode(
    'ChpDcmVhdGVQcmVzaWduZWRVUkxSZXNwb25zZRIQCgN1cmwYASABKAlSA3VybA==');

