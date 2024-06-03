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

import 'sage.pbenum.dart';

export 'sage.pbenum.dart';

/// // // // // // // // // // // //
/// Models
/// // // // // // // // // // // //
class Token extends $pb.GeneratedMessage {
  factory Token({
    $core.String? idToken,
    $core.String? accessToken,
    $core.String? refreshToken,
  }) {
    final $result = create();
    if (idToken != null) {
      $result.idToken = idToken;
    }
    if (accessToken != null) {
      $result.accessToken = accessToken;
    }
    if (refreshToken != null) {
      $result.refreshToken = refreshToken;
    }
    return $result;
  }
  Token._() : super();
  factory Token.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Token.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Token', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'idToken')
    ..aOS(2, _omitFieldNames ? '' : 'accessToken')
    ..aOS(3, _omitFieldNames ? '' : 'refreshToken')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Token clone() => Token()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Token copyWith(void Function(Token) updates) => super.copyWith((message) => updates(message as Token)) as Token;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Token create() => Token._();
  Token createEmptyInstance() => create();
  static $pb.PbList<Token> createRepeated() => $pb.PbList<Token>();
  @$core.pragma('dart2js:noInline')
  static Token getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Token>(create);
  static Token? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get idToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set idToken($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIdToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearIdToken() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get accessToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set accessToken($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAccessToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccessToken() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get refreshToken => $_getSZ(2);
  @$pb.TagNumber(3)
  set refreshToken($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRefreshToken() => $_has(2);
  @$pb.TagNumber(3)
  void clearRefreshToken() => clearField(3);
}

class User extends $pb.GeneratedMessage {
  factory User({
    $core.String? id,
    $core.String? firstName,
    $core.String? lastName,
    $core.String? email,
    $core.double? rating,
    Gender? gender,
    $core.int? birthday,
    $core.String? videoUrl,
    Location? location,
    Preferences? preferences,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (firstName != null) {
      $result.firstName = firstName;
    }
    if (lastName != null) {
      $result.lastName = lastName;
    }
    if (email != null) {
      $result.email = email;
    }
    if (rating != null) {
      $result.rating = rating;
    }
    if (gender != null) {
      $result.gender = gender;
    }
    if (birthday != null) {
      $result.birthday = birthday;
    }
    if (videoUrl != null) {
      $result.videoUrl = videoUrl;
    }
    if (location != null) {
      $result.location = location;
    }
    if (preferences != null) {
      $result.preferences = preferences;
    }
    return $result;
  }
  User._() : super();
  factory User.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory User.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'User', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'firstName')
    ..aOS(3, _omitFieldNames ? '' : 'lastName')
    ..aOS(4, _omitFieldNames ? '' : 'email')
    ..a<$core.double>(5, _omitFieldNames ? '' : 'rating', $pb.PbFieldType.OD)
    ..e<Gender>(6, _omitFieldNames ? '' : 'gender', $pb.PbFieldType.OE, defaultOrMaker: Gender.MAN, valueOf: Gender.valueOf, enumValues: Gender.values)
    ..a<$core.int>(7, _omitFieldNames ? '' : 'birthday', $pb.PbFieldType.O3)
    ..aOS(8, _omitFieldNames ? '' : 'videoUrl')
    ..aOM<Location>(9, _omitFieldNames ? '' : 'location', subBuilder: Location.create)
    ..aOM<Preferences>(10, _omitFieldNames ? '' : 'preferences', subBuilder: Preferences.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  User clone() => User()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  User copyWith(void Function(User) updates) => super.copyWith((message) => updates(message as User)) as User;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static User create() => User._();
  User createEmptyInstance() => create();
  static $pb.PbList<User> createRepeated() => $pb.PbList<User>();
  @$core.pragma('dart2js:noInline')
  static User getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<User>(create);
  static User? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get firstName => $_getSZ(1);
  @$pb.TagNumber(2)
  set firstName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFirstName() => $_has(1);
  @$pb.TagNumber(2)
  void clearFirstName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get lastName => $_getSZ(2);
  @$pb.TagNumber(3)
  set lastName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLastName() => $_has(2);
  @$pb.TagNumber(3)
  void clearLastName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get email => $_getSZ(3);
  @$pb.TagNumber(4)
  set email($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasEmail() => $_has(3);
  @$pb.TagNumber(4)
  void clearEmail() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get rating => $_getN(4);
  @$pb.TagNumber(5)
  set rating($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasRating() => $_has(4);
  @$pb.TagNumber(5)
  void clearRating() => clearField(5);

  @$pb.TagNumber(6)
  Gender get gender => $_getN(5);
  @$pb.TagNumber(6)
  set gender(Gender v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasGender() => $_has(5);
  @$pb.TagNumber(6)
  void clearGender() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get birthday => $_getIZ(6);
  @$pb.TagNumber(7)
  set birthday($core.int v) { $_setSignedInt32(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasBirthday() => $_has(6);
  @$pb.TagNumber(7)
  void clearBirthday() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get videoUrl => $_getSZ(7);
  @$pb.TagNumber(8)
  set videoUrl($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasVideoUrl() => $_has(7);
  @$pb.TagNumber(8)
  void clearVideoUrl() => clearField(8);

  @$pb.TagNumber(9)
  Location get location => $_getN(8);
  @$pb.TagNumber(9)
  set location(Location v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasLocation() => $_has(8);
  @$pb.TagNumber(9)
  void clearLocation() => clearField(9);
  @$pb.TagNumber(9)
  Location ensureLocation() => $_ensure(8);

  @$pb.TagNumber(10)
  Preferences get preferences => $_getN(9);
  @$pb.TagNumber(10)
  set preferences(Preferences v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasPreferences() => $_has(9);
  @$pb.TagNumber(10)
  void clearPreferences() => clearField(10);
  @$pb.TagNumber(10)
  Preferences ensurePreferences() => $_ensure(9);
}

class CreateUserRequest extends $pb.GeneratedMessage {
  factory CreateUserRequest({
    User? user,
  }) {
    final $result = create();
    if (user != null) {
      $result.user = user;
    }
    return $result;
  }
  CreateUserRequest._() : super();
  factory CreateUserRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateUserRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateUserRequest', createEmptyInstance: create)
    ..aOM<User>(1, _omitFieldNames ? '' : 'user', subBuilder: User.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateUserRequest clone() => CreateUserRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateUserRequest copyWith(void Function(CreateUserRequest) updates) => super.copyWith((message) => updates(message as CreateUserRequest)) as CreateUserRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateUserRequest create() => CreateUserRequest._();
  CreateUserRequest createEmptyInstance() => create();
  static $pb.PbList<CreateUserRequest> createRepeated() => $pb.PbList<CreateUserRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateUserRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateUserRequest>(create);
  static CreateUserRequest? _defaultInstance;

  @$pb.TagNumber(1)
  User get user => $_getN(0);
  @$pb.TagNumber(1)
  set user(User v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearUser() => clearField(1);
  @$pb.TagNumber(1)
  User ensureUser() => $_ensure(0);
}

class CreateUserResponse extends $pb.GeneratedMessage {
  factory CreateUserResponse({
    User? user,
  }) {
    final $result = create();
    if (user != null) {
      $result.user = user;
    }
    return $result;
  }
  CreateUserResponse._() : super();
  factory CreateUserResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateUserResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateUserResponse', createEmptyInstance: create)
    ..aOM<User>(1, _omitFieldNames ? '' : 'user', subBuilder: User.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateUserResponse clone() => CreateUserResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateUserResponse copyWith(void Function(CreateUserResponse) updates) => super.copyWith((message) => updates(message as CreateUserResponse)) as CreateUserResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateUserResponse create() => CreateUserResponse._();
  CreateUserResponse createEmptyInstance() => create();
  static $pb.PbList<CreateUserResponse> createRepeated() => $pb.PbList<CreateUserResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateUserResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateUserResponse>(create);
  static CreateUserResponse? _defaultInstance;

  @$pb.TagNumber(1)
  User get user => $_getN(0);
  @$pb.TagNumber(1)
  set user(User v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearUser() => clearField(1);
  @$pb.TagNumber(1)
  User ensureUser() => $_ensure(0);
}

class GetUserRequest extends $pb.GeneratedMessage {
  factory GetUserRequest({
    $core.String? id,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    return $result;
  }
  GetUserRequest._() : super();
  factory GetUserRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetUserRequest', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserRequest clone() => GetUserRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserRequest copyWith(void Function(GetUserRequest) updates) => super.copyWith((message) => updates(message as GetUserRequest)) as GetUserRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserRequest create() => GetUserRequest._();
  GetUserRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserRequest> createRepeated() => $pb.PbList<GetUserRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserRequest>(create);
  static GetUserRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
}

class GetUserResponse extends $pb.GeneratedMessage {
  factory GetUserResponse({
    User? user,
  }) {
    final $result = create();
    if (user != null) {
      $result.user = user;
    }
    return $result;
  }
  GetUserResponse._() : super();
  factory GetUserResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetUserResponse', createEmptyInstance: create)
    ..aOM<User>(1, _omitFieldNames ? '' : 'user', subBuilder: User.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserResponse clone() => GetUserResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserResponse copyWith(void Function(GetUserResponse) updates) => super.copyWith((message) => updates(message as GetUserResponse)) as GetUserResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserResponse create() => GetUserResponse._();
  GetUserResponse createEmptyInstance() => create();
  static $pb.PbList<GetUserResponse> createRepeated() => $pb.PbList<GetUserResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUserResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserResponse>(create);
  static GetUserResponse? _defaultInstance;

  @$pb.TagNumber(1)
  User get user => $_getN(0);
  @$pb.TagNumber(1)
  set user(User v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearUser() => clearField(1);
  @$pb.TagNumber(1)
  User ensureUser() => $_ensure(0);
}

class Location extends $pb.GeneratedMessage {
  factory Location({
    $core.int? lat,
    $core.int? long,
  }) {
    final $result = create();
    if (lat != null) {
      $result.lat = lat;
    }
    if (long != null) {
      $result.long = long;
    }
    return $result;
  }
  Location._() : super();
  factory Location.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Location.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Location', createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'lat', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'long', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Location clone() => Location()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Location copyWith(void Function(Location) updates) => super.copyWith((message) => updates(message as Location)) as Location;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Location create() => Location._();
  Location createEmptyInstance() => create();
  static $pb.PbList<Location> createRepeated() => $pb.PbList<Location>();
  @$core.pragma('dart2js:noInline')
  static Location getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Location>(create);
  static Location? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get lat => $_getIZ(0);
  @$pb.TagNumber(1)
  set lat($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLat() => $_has(0);
  @$pb.TagNumber(1)
  void clearLat() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get long => $_getIZ(1);
  @$pb.TagNumber(2)
  set long($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLong() => $_has(1);
  @$pb.TagNumber(2)
  void clearLong() => clearField(2);
}

class Preferences extends $pb.GeneratedMessage {
  factory Preferences({
    $core.int? ageMin,
    $core.int? ageMax,
    Proximity? proximity,
    $core.Iterable<Gender>? gender,
  }) {
    final $result = create();
    if (ageMin != null) {
      $result.ageMin = ageMin;
    }
    if (ageMax != null) {
      $result.ageMax = ageMax;
    }
    if (proximity != null) {
      $result.proximity = proximity;
    }
    if (gender != null) {
      $result.gender.addAll(gender);
    }
    return $result;
  }
  Preferences._() : super();
  factory Preferences.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Preferences.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Preferences', createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'ageMin', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'ageMax', $pb.PbFieldType.O3)
    ..e<Proximity>(3, _omitFieldNames ? '' : 'proximity', $pb.PbFieldType.OE, defaultOrMaker: Proximity.HOOD, valueOf: Proximity.valueOf, enumValues: Proximity.values)
    ..pc<Gender>(4, _omitFieldNames ? '' : 'gender', $pb.PbFieldType.KE, valueOf: Gender.valueOf, enumValues: Gender.values, defaultEnumValue: Gender.MAN)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Preferences clone() => Preferences()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Preferences copyWith(void Function(Preferences) updates) => super.copyWith((message) => updates(message as Preferences)) as Preferences;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Preferences create() => Preferences._();
  Preferences createEmptyInstance() => create();
  static $pb.PbList<Preferences> createRepeated() => $pb.PbList<Preferences>();
  @$core.pragma('dart2js:noInline')
  static Preferences getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Preferences>(create);
  static Preferences? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get ageMin => $_getIZ(0);
  @$pb.TagNumber(1)
  set ageMin($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAgeMin() => $_has(0);
  @$pb.TagNumber(1)
  void clearAgeMin() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get ageMax => $_getIZ(1);
  @$pb.TagNumber(2)
  set ageMax($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAgeMax() => $_has(1);
  @$pb.TagNumber(2)
  void clearAgeMax() => clearField(2);

  @$pb.TagNumber(3)
  Proximity get proximity => $_getN(2);
  @$pb.TagNumber(3)
  set proximity(Proximity v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasProximity() => $_has(2);
  @$pb.TagNumber(3)
  void clearProximity() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<Gender> get gender => $_getList(3);
}

/// // // // // // // // // // // //
/// Connectivity & Messaging
/// // // // // // // // // // // //
class SDP extends $pb.GeneratedMessage {
  factory SDP({
    $core.int? type,
    $core.String? message,
    $core.String? description,
  }) {
    final $result = create();
    if (type != null) {
      $result.type = type;
    }
    if (message != null) {
      $result.message = message;
    }
    if (description != null) {
      $result.description = description;
    }
    return $result;
  }
  SDP._() : super();
  factory SDP.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SDP.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SDP', createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'type', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SDP clone() => SDP()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SDP copyWith(void Function(SDP) updates) => super.copyWith((message) => updates(message as SDP)) as SDP;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SDP create() => SDP._();
  SDP createEmptyInstance() => create();
  static $pb.PbList<SDP> createRepeated() => $pb.PbList<SDP>();
  @$core.pragma('dart2js:noInline')
  static SDP getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SDP>(create);
  static SDP? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get type => $_getIZ(0);
  @$pb.TagNumber(1)
  set type($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => clearField(3);
}

class ICE extends $pb.GeneratedMessage {
  factory ICE({
    SDP? sdp,
    $core.String? streamId,
    $core.int? lineIndex,
    $core.String? serverUrl,
  }) {
    final $result = create();
    if (sdp != null) {
      $result.sdp = sdp;
    }
    if (streamId != null) {
      $result.streamId = streamId;
    }
    if (lineIndex != null) {
      $result.lineIndex = lineIndex;
    }
    if (serverUrl != null) {
      $result.serverUrl = serverUrl;
    }
    return $result;
  }
  ICE._() : super();
  factory ICE.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ICE.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ICE', createEmptyInstance: create)
    ..aOM<SDP>(1, _omitFieldNames ? '' : 'sdp', subBuilder: SDP.create)
    ..aOS(2, _omitFieldNames ? '' : 'streamId')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'lineIndex', $pb.PbFieldType.O3)
    ..aOS(4, _omitFieldNames ? '' : 'serverUrl')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ICE clone() => ICE()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ICE copyWith(void Function(ICE) updates) => super.copyWith((message) => updates(message as ICE)) as ICE;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ICE create() => ICE._();
  ICE createEmptyInstance() => create();
  static $pb.PbList<ICE> createRepeated() => $pb.PbList<ICE>();
  @$core.pragma('dart2js:noInline')
  static ICE getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ICE>(create);
  static ICE? _defaultInstance;

  @$pb.TagNumber(1)
  SDP get sdp => $_getN(0);
  @$pb.TagNumber(1)
  set sdp(SDP v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasSdp() => $_has(0);
  @$pb.TagNumber(1)
  void clearSdp() => clearField(1);
  @$pb.TagNumber(1)
  SDP ensureSdp() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get streamId => $_getSZ(1);
  @$pb.TagNumber(2)
  set streamId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasStreamId() => $_has(1);
  @$pb.TagNumber(2)
  void clearStreamId() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get lineIndex => $_getIZ(2);
  @$pb.TagNumber(3)
  set lineIndex($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLineIndex() => $_has(2);
  @$pb.TagNumber(3)
  void clearLineIndex() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get serverUrl => $_getSZ(3);
  @$pb.TagNumber(4)
  set serverUrl($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasServerUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearServerUrl() => clearField(4);
}

enum SignalingRequest_Message {
  sdp, 
  ice, 
  notSet
}

class SignalingRequest extends $pb.GeneratedMessage {
  factory SignalingRequest({
    SDP? sdp,
    ICE? ice,
  }) {
    final $result = create();
    if (sdp != null) {
      $result.sdp = sdp;
    }
    if (ice != null) {
      $result.ice = ice;
    }
    return $result;
  }
  SignalingRequest._() : super();
  factory SignalingRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SignalingRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, SignalingRequest_Message> _SignalingRequest_MessageByTag = {
    1 : SignalingRequest_Message.sdp,
    2 : SignalingRequest_Message.ice,
    0 : SignalingRequest_Message.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SignalingRequest', createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOM<SDP>(1, _omitFieldNames ? '' : 'sdp', subBuilder: SDP.create)
    ..aOM<ICE>(2, _omitFieldNames ? '' : 'ice', subBuilder: ICE.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SignalingRequest clone() => SignalingRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SignalingRequest copyWith(void Function(SignalingRequest) updates) => super.copyWith((message) => updates(message as SignalingRequest)) as SignalingRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SignalingRequest create() => SignalingRequest._();
  SignalingRequest createEmptyInstance() => create();
  static $pb.PbList<SignalingRequest> createRepeated() => $pb.PbList<SignalingRequest>();
  @$core.pragma('dart2js:noInline')
  static SignalingRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SignalingRequest>(create);
  static SignalingRequest? _defaultInstance;

  SignalingRequest_Message whichMessage() => _SignalingRequest_MessageByTag[$_whichOneof(0)]!;
  void clearMessage() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  SDP get sdp => $_getN(0);
  @$pb.TagNumber(1)
  set sdp(SDP v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasSdp() => $_has(0);
  @$pb.TagNumber(1)
  void clearSdp() => clearField(1);
  @$pb.TagNumber(1)
  SDP ensureSdp() => $_ensure(0);

  @$pb.TagNumber(2)
  ICE get ice => $_getN(1);
  @$pb.TagNumber(2)
  set ice(ICE v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasIce() => $_has(1);
  @$pb.TagNumber(2)
  void clearIce() => clearField(2);
  @$pb.TagNumber(2)
  ICE ensureIce() => $_ensure(1);
}

/// // // // // // // // // // // //
/// Presigned URL
/// // // // // // // // // // // //
class PresignedURLRequest extends $pb.GeneratedMessage {
  factory PresignedURLRequest({
    $core.String? action,
    $core.String? fileName,
  }) {
    final $result = create();
    if (action != null) {
      $result.action = action;
    }
    if (fileName != null) {
      $result.fileName = fileName;
    }
    return $result;
  }
  PresignedURLRequest._() : super();
  factory PresignedURLRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PresignedURLRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PresignedURLRequest', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'action')
    ..aOS(2, _omitFieldNames ? '' : 'fileName')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PresignedURLRequest clone() => PresignedURLRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PresignedURLRequest copyWith(void Function(PresignedURLRequest) updates) => super.copyWith((message) => updates(message as PresignedURLRequest)) as PresignedURLRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PresignedURLRequest create() => PresignedURLRequest._();
  PresignedURLRequest createEmptyInstance() => create();
  static $pb.PbList<PresignedURLRequest> createRepeated() => $pb.PbList<PresignedURLRequest>();
  @$core.pragma('dart2js:noInline')
  static PresignedURLRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PresignedURLRequest>(create);
  static PresignedURLRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get action => $_getSZ(0);
  @$pb.TagNumber(1)
  set action($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAction() => $_has(0);
  @$pb.TagNumber(1)
  void clearAction() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get fileName => $_getSZ(1);
  @$pb.TagNumber(2)
  set fileName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFileName() => $_has(1);
  @$pb.TagNumber(2)
  void clearFileName() => clearField(2);
}

class PresignedURLResponse extends $pb.GeneratedMessage {
  factory PresignedURLResponse({
    $core.String? url,
    PresignedURLRequest? request,
  }) {
    final $result = create();
    if (url != null) {
      $result.url = url;
    }
    if (request != null) {
      $result.request = request;
    }
    return $result;
  }
  PresignedURLResponse._() : super();
  factory PresignedURLResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PresignedURLResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PresignedURLResponse', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'url')
    ..aOM<PresignedURLRequest>(2, _omitFieldNames ? '' : 'request', subBuilder: PresignedURLRequest.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PresignedURLResponse clone() => PresignedURLResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PresignedURLResponse copyWith(void Function(PresignedURLResponse) updates) => super.copyWith((message) => updates(message as PresignedURLResponse)) as PresignedURLResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PresignedURLResponse create() => PresignedURLResponse._();
  PresignedURLResponse createEmptyInstance() => create();
  static $pb.PbList<PresignedURLResponse> createRepeated() => $pb.PbList<PresignedURLResponse>();
  @$core.pragma('dart2js:noInline')
  static PresignedURLResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PresignedURLResponse>(create);
  static PresignedURLResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get url => $_getSZ(0);
  @$pb.TagNumber(1)
  set url($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUrl() => $_has(0);
  @$pb.TagNumber(1)
  void clearUrl() => clearField(1);

  @$pb.TagNumber(2)
  PresignedURLRequest get request => $_getN(1);
  @$pb.TagNumber(2)
  set request(PresignedURLRequest v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasRequest() => $_has(1);
  @$pb.TagNumber(2)
  void clearRequest() => clearField(2);
  @$pb.TagNumber(2)
  PresignedURLRequest ensureRequest() => $_ensure(1);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
