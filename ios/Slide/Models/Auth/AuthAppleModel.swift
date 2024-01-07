
import Foundation
import AuthenticationServices
import NIOHPACK
import GRPC

extension AuthModel {
    func requestAppleScopes(_ request: ASAuthorizationAppleIDRequest){
        request.requestedScopes = [.fullName, .email]
    }
    
    func onAppleSignUpComplete(_ authResult: Result<ASAuthorization, Error>) {
        switch authResult {
        case .success(let authResults):
            let appleCredentials = authResults.credential as! ASAuthorizationAppleIDCredential

            Task {
                // Create user account, sending all info separately to generate true credentials w/ refresh
                let authToken = String(decoding: appleCredentials.identityToken!, as: UTF8.self)
                let headers: HPACKHeaders = ["Authorization": "Bearer \(authToken)",
                                             "X-Auth-Token": String(decoding: appleCredentials.authorizationCode!, as: UTF8.self)]
                
                guard let userResponse = try? await SageService.shared.client.createUser(CreateUserRequest.with {
                    $0.user.id = appleCredentials.user
                    $0.user.name = appleCredentials.fullName?.description ?? ""
                    $0.user.email = appleCredentials.email ?? ""
                }, callOptions: CallOptions(customMetadata: headers))
                else { return }
                
                UserModel.shared.user = userResponse.user
            }
        case .failure(let error):
            print("Authorization failed: \(error.localizedDescription)")
        }
    }
}
