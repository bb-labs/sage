
import NIO
import GRPC

class SageCreateUserAuthInterceptor: ClientInterceptor<CreateUserRequest, CreateUserResponse> {
    override func send(
        _ part: GRPCClientRequestPart<CreateUserRequest>,
        promise: EventLoopPromise<Void>?,
        context: ClientInterceptorContext<CreateUserRequest, CreateUserResponse>
    ) {
        switch part {
        case let .metadata(headers):
            break
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
            break
        case let .end(status, trailers):
            break
        default:
            break
        }

        context.receive(part)
    }
}

final class SageServiceInterceptorFactory: SageClientInterceptorFactoryProtocol {
    func makeCreateUserInterceptors() -> [ClientInterceptor<CreateUserRequest, CreateUserResponse>] {
        return [SageCreateUserAuthInterceptor()]
    }
}
