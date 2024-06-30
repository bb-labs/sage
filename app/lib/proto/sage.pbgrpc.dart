//
//  Generated code. Do not modify.
//  source: sage.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'sage.pb.dart' as $0;

export 'sage.pb.dart';

@$pb.GrpcServiceName('Sage')
class SageClient extends $grpc.Client {
  static final _$getUser = $grpc.ClientMethod<$0.GetUserRequest, $0.GetUserResponse>(
      '/Sage/GetUser',
      ($0.GetUserRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetUserResponse.fromBuffer(value));
  static final _$updateUser = $grpc.ClientMethod<$0.UpdateUserRequest, $0.UpdateUserRequest>(
      '/Sage/UpdateUser',
      ($0.UpdateUserRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UpdateUserRequest.fromBuffer(value));
  static final _$createUser = $grpc.ClientMethod<$0.CreateUserRequest, $0.CreateUserResponse>(
      '/Sage/CreateUser',
      ($0.CreateUserRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CreateUserResponse.fromBuffer(value));
  static final _$createPresignedURL = $grpc.ClientMethod<$0.CreatePresignedURLRequest, $0.CreatePresignedURLResponse>(
      '/Sage/CreatePresignedURL',
      ($0.CreatePresignedURLRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CreatePresignedURLResponse.fromBuffer(value));

  SageClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.GetUserResponse> getUser($0.GetUserRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUser, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateUserRequest> updateUser($0.UpdateUserRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateUser, request, options: options);
  }

  $grpc.ResponseFuture<$0.CreateUserResponse> createUser($0.CreateUserRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createUser, request, options: options);
  }

  $grpc.ResponseFuture<$0.CreatePresignedURLResponse> createPresignedURL($0.CreatePresignedURLRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createPresignedURL, request, options: options);
  }
}

@$pb.GrpcServiceName('Sage')
abstract class SageServiceBase extends $grpc.Service {
  $core.String get $name => 'Sage';

  SageServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GetUserRequest, $0.GetUserResponse>(
        'GetUser',
        getUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetUserRequest.fromBuffer(value),
        ($0.GetUserResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateUserRequest, $0.UpdateUserRequest>(
        'UpdateUser',
        updateUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdateUserRequest.fromBuffer(value),
        ($0.UpdateUserRequest value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateUserRequest, $0.CreateUserResponse>(
        'CreateUser',
        createUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateUserRequest.fromBuffer(value),
        ($0.CreateUserResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreatePresignedURLRequest, $0.CreatePresignedURLResponse>(
        'CreatePresignedURL',
        createPresignedURL_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreatePresignedURLRequest.fromBuffer(value),
        ($0.CreatePresignedURLResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.GetUserResponse> getUser_Pre($grpc.ServiceCall call, $async.Future<$0.GetUserRequest> request) async {
    return getUser(call, await request);
  }

  $async.Future<$0.UpdateUserRequest> updateUser_Pre($grpc.ServiceCall call, $async.Future<$0.UpdateUserRequest> request) async {
    return updateUser(call, await request);
  }

  $async.Future<$0.CreateUserResponse> createUser_Pre($grpc.ServiceCall call, $async.Future<$0.CreateUserRequest> request) async {
    return createUser(call, await request);
  }

  $async.Future<$0.CreatePresignedURLResponse> createPresignedURL_Pre($grpc.ServiceCall call, $async.Future<$0.CreatePresignedURLRequest> request) async {
    return createPresignedURL(call, await request);
  }

  $async.Future<$0.GetUserResponse> getUser($grpc.ServiceCall call, $0.GetUserRequest request);
  $async.Future<$0.UpdateUserRequest> updateUser($grpc.ServiceCall call, $0.UpdateUserRequest request);
  $async.Future<$0.CreateUserResponse> createUser($grpc.ServiceCall call, $0.CreateUserRequest request);
  $async.Future<$0.CreatePresignedURLResponse> createPresignedURL($grpc.ServiceCall call, $0.CreatePresignedURLRequest request);
}
