//
//  Generated code. Do not modify.
//  source: sage.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class Gender extends $pb.ProtobufEnum {
  static const Gender MAN = Gender._(0, _omitEnumNames ? '' : 'MAN');
  static const Gender WOMAN = Gender._(1, _omitEnumNames ? '' : 'WOMAN');
  static const Gender HUMAN = Gender._(2, _omitEnumNames ? '' : 'HUMAN');

  static const $core.List<Gender> values = <Gender> [
    MAN,
    WOMAN,
    HUMAN,
  ];

  static final $core.Map<$core.int, Gender> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Gender? valueOf($core.int value) => _byValue[value];

  const Gender._($core.int v, $core.String n) : super(v, n);
}

class GenderPlural extends $pb.ProtobufEnum {
  static const GenderPlural MEN = GenderPlural._(0, _omitEnumNames ? '' : 'MEN');
  static const GenderPlural WOMEN = GenderPlural._(1, _omitEnumNames ? '' : 'WOMEN');
  static const GenderPlural HUMANS = GenderPlural._(2, _omitEnumNames ? '' : 'HUMANS');

  static const $core.List<GenderPlural> values = <GenderPlural> [
    MEN,
    WOMEN,
    HUMANS,
  ];

  static final $core.Map<$core.int, GenderPlural> _byValue = $pb.ProtobufEnum.initByValue(values);
  static GenderPlural? valueOf($core.int value) => _byValue[value];

  const GenderPlural._($core.int v, $core.String n) : super(v, n);
}

class Proximity extends $pb.ProtobufEnum {
  static const Proximity HOOD = Proximity._(0, _omitEnumNames ? '' : 'HOOD');
  static const Proximity CITY = Proximity._(1, _omitEnumNames ? '' : 'CITY');
  static const Proximity METRO = Proximity._(2, _omitEnumNames ? '' : 'METRO');

  static const $core.List<Proximity> values = <Proximity> [
    HOOD,
    CITY,
    METRO,
  ];

  static final $core.Map<$core.int, Proximity> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Proximity? valueOf($core.int value) => _byValue[value];

  const Proximity._($core.int v, $core.String n) : super(v, n);
}

/// // // // // // // // // // // //
/// Presigned URL
/// // // // // // // // // // // //
class PresignAction extends $pb.ProtobufEnum {
  static const PresignAction GET = PresignAction._(0, _omitEnumNames ? '' : 'GET');
  static const PresignAction PUT = PresignAction._(1, _omitEnumNames ? '' : 'PUT');
  static const PresignAction DELETE = PresignAction._(2, _omitEnumNames ? '' : 'DELETE');

  static const $core.List<PresignAction> values = <PresignAction> [
    GET,
    PUT,
    DELETE,
  ];

  static final $core.Map<$core.int, PresignAction> _byValue = $pb.ProtobufEnum.initByValue(values);
  static PresignAction? valueOf($core.int value) => _byValue[value];

  const PresignAction._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
