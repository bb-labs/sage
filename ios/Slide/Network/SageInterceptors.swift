
import NIO
import GRPC

class SageAuthClientInterceptor: ClientInterceptor<CreateUserRequest, CreateUserResponse> {
    override func send(
        _ part: GRPCClientRequestPart<CreateUserRequest>,
        promise: EventLoopPromise<Void>?,
        context: ClientInterceptorContext<CreateUserRequest, CreateUserResponse>
    ) {
        switch part {
        case let .metadata(headers):
            print("> Starting '\(context.path)' RPC, headers: \(headers)")
        default:
            break
        }
        
        context.send(part, promise: promise)
    }

    override func receive(
       _ part: GRPCClientResponsePart<CreateUserResponse>,
       context: ClientInterceptorContext<CreateUserRequest, CreateUserResponse>
    ) {
        switch part {
        case let .metadata(headers):
            print("< Received headers: \(headers)")
        default:
            break
        }

        context.receive(part)
    }
}

final class SageServiceInterceptorFactory: SageClientInterceptorFactoryProtocol {
    func makeCreateUserInterceptors() -> [ClientInterceptor<CreateUserRequest, CreateUserResponse>] {
        return [SageAuthClientInterceptor()]
    }
}
