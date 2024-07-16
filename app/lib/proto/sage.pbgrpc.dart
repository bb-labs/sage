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
  static final _$updateUser = $grpc.ClientMethod<$0.UpdateUserRequest, $0.UpdateUserResponse>(
      '/Sage/UpdateUser',
      ($0.UpdateUserRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UpdateUserResponse.fromBuffer(value));
  static final _$createUser = $grpc.ClientMethod<$0.CreateUserRequest, $0.CreateUserResponse>(
      '/Sage/CreateUser',
      ($0.CreateUserRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CreateUserResponse.fromBuffer(value));
  static final _$getFeed = $grpc.ClientMethod<$0.GetFeedRequest, $0.GetFeedResponse>(
      '/Sage/GetFeed',
      ($0.GetFeedRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetFeedResponse.fromBuffer(value));
  static final _$likeUser = $grpc.ClientMethod<$0.LikeUserRequest, $0.LikeUserResponse>(
      '/Sage/LikeUser',
      ($0.LikeUserRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.LikeUserResponse.fromBuffer(value));
  static final _$unlikeUser = $grpc.ClientMethod<$0.UnlikeUserRequest, $0.UnlikeUserResponse>(
      '/Sage/UnlikeUser',
      ($0.UnlikeUserRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UnlikeUserResponse.fromBuffer(value));
  static final _$getLikes = $grpc.ClientMethod<$0.GetLikesRequest, $0.GetLikesResponse>(
      '/Sage/GetLikes',
      ($0.GetLikesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetLikesResponse.fromBuffer(value));
  static final _$getMatches = $grpc.ClientMethod<$0.GetMatchesRequest, $0.GetMatchesResponse>(
      '/Sage/GetMatches',
      ($0.GetMatchesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetMatchesResponse.fromBuffer(value));
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

  $grpc.ResponseFuture<$0.UpdateUserResponse> updateUser($0.UpdateUserRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateUser, request, options: options);
  }

  $grpc.ResponseFuture<$0.CreateUserResponse> createUser($0.CreateUserRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createUser, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetFeedResponse> getFeed($0.GetFeedRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getFeed, request, options: options);
  }

  $grpc.ResponseFuture<$0.LikeUserResponse> likeUser($0.LikeUserRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$likeUser, request, options: options);
  }

  $grpc.ResponseFuture<$0.UnlikeUserResponse> unlikeUser($0.UnlikeUserRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$unlikeUser, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetLikesResponse> getLikes($0.GetLikesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getLikes, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetMatchesResponse> getMatches($0.GetMatchesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMatches, request, options: options);
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
    $addMethod($grpc.ServiceMethod<$0.UpdateUserRequest, $0.UpdateUserResponse>(
        'UpdateUser',
        updateUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdateUserRequest.fromBuffer(value),
        ($0.UpdateUserResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateUserRequest, $0.CreateUserResponse>(
        'CreateUser',
        createUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateUserRequest.fromBuffer(value),
        ($0.CreateUserResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetFeedRequest, $0.GetFeedResponse>(
        'GetFeed',
        getFeed_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetFeedRequest.fromBuffer(value),
        ($0.GetFeedResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.LikeUserRequest, $0.LikeUserResponse>(
        'LikeUser',
        likeUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.LikeUserRequest.fromBuffer(value),
        ($0.LikeUserResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UnlikeUserRequest, $0.UnlikeUserResponse>(
        'UnlikeUser',
        unlikeUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UnlikeUserRequest.fromBuffer(value),
        ($0.UnlikeUserResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetLikesRequest, $0.GetLikesResponse>(
        'GetLikes',
        getLikes_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetLikesRequest.fromBuffer(value),
        ($0.GetLikesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetMatchesRequest, $0.GetMatchesResponse>(
        'GetMatches',
        getMatches_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetMatchesRequest.fromBuffer(value),
        ($0.GetMatchesResponse value) => value.writeToBuffer()));
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

  $async.Future<$0.UpdateUserResponse> updateUser_Pre($grpc.ServiceCall call, $async.Future<$0.UpdateUserRequest> request) async {
    return updateUser(call, await request);
  }

  $async.Future<$0.CreateUserResponse> createUser_Pre($grpc.ServiceCall call, $async.Future<$0.CreateUserRequest> request) async {
    return createUser(call, await request);
  }

  $async.Future<$0.GetFeedResponse> getFeed_Pre($grpc.ServiceCall call, $async.Future<$0.GetFeedRequest> request) async {
    return getFeed(call, await request);
  }

  $async.Future<$0.LikeUserResponse> likeUser_Pre($grpc.ServiceCall call, $async.Future<$0.LikeUserRequest> request) async {
    return likeUser(call, await request);
  }

  $async.Future<$0.UnlikeUserResponse> unlikeUser_Pre($grpc.ServiceCall call, $async.Future<$0.UnlikeUserRequest> request) async {
    return unlikeUser(call, await request);
  }

  $async.Future<$0.GetLikesResponse> getLikes_Pre($grpc.ServiceCall call, $async.Future<$0.GetLikesRequest> request) async {
    return getLikes(call, await request);
  }

  $async.Future<$0.GetMatchesResponse> getMatches_Pre($grpc.ServiceCall call, $async.Future<$0.GetMatchesRequest> request) async {
    return getMatches(call, await request);
  }

  $async.Future<$0.CreatePresignedURLResponse> createPresignedURL_Pre($grpc.ServiceCall call, $async.Future<$0.CreatePresignedURLRequest> request) async {
    return createPresignedURL(call, await request);
  }

  $async.Future<$0.GetUserResponse> getUser($grpc.ServiceCall call, $0.GetUserRequest request);
  $async.Future<$0.UpdateUserResponse> updateUser($grpc.ServiceCall call, $0.UpdateUserRequest request);
  $async.Future<$0.CreateUserResponse> createUser($grpc.ServiceCall call, $0.CreateUserRequest request);
  $async.Future<$0.GetFeedResponse> getFeed($grpc.ServiceCall call, $0.GetFeedRequest request);
  $async.Future<$0.LikeUserResponse> likeUser($grpc.ServiceCall call, $0.LikeUserRequest request);
  $async.Future<$0.UnlikeUserResponse> unlikeUser($grpc.ServiceCall call, $0.UnlikeUserRequest request);
  $async.Future<$0.GetLikesResponse> getLikes($grpc.ServiceCall call, $0.GetLikesRequest request);
  $async.Future<$0.GetMatchesResponse> getMatches($grpc.ServiceCall call, $0.GetMatchesRequest request);
  $async.Future<$0.CreatePresignedURLResponse> createPresignedURL($grpc.ServiceCall call, $0.CreatePresignedURLRequest request);
}
