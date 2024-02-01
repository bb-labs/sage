
import NIO
import GRPC

class SageMessageUserAuthInterceptor: ClientInterceptor<MessageUserRequest, Message> {
    override func send(
        _ part: GRPCClientRequestPart<MessageUserRequest>,
        promise: EventLoopPromise<Void>?,
        context: ClientInterceptorContext<MessageUserRequest, Message>
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
       _ part: GRPCClientResponsePart<Message>,
       context: ClientInterceptorContext<MessageUserRequest, Message>
    ) {
        switch part {
        case let .metadata(headers):
            print("< Received headers: \(headers)")
        case let .end(status, trailers):
          print("< Response stream closed with status: '\(status)' and trailers: \(trailers)")
        default:
            break
        }

        context.receive(part)
    }
}

class SageCreateUserAuthInterceptor: ClientInterceptor<CreateUserRequest, CreateUserResponse> {
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
        case let .end(status, trailers):
          print("< Response stream closed with status: '\(status)' and trailers: \(trailers)")
        default:
            break
        }

        context.receive(part)
    }
}

final class SageServiceInterceptorFactory: SageClientInterceptorFactoryProtocol {
    func makeMessageUserInterceptors() -> [ClientInterceptor<MessageUserRequest, Message>] {
        return []
    }
    
    func makeCreateUserInterceptors() -> [ClientInterceptor<CreateUserRequest, CreateUserResponse>] {
        return [SageCreateUserAuthInterceptor()]
    }
}
