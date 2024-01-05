
import Foundation
import AuthenticationServices
import NIOHPACK
import GRPC

struct AppleCredentials: Credentials {
    var user: String?
    var email: String?
    var identityToken: String?
    var refreshToken: String?
}

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
                let headers: HPACKHeaders = ["authorization": "Bearer \(authToken)"]
                
                let response = try await self.sageService.client.createUser(CreateUserRequest.with {
                    $0.user.id = appleCredentials.user
                    $0.user.email = appleCredentials.email ?? ""
                    $0.token.authCode = String(decoding: appleCredentials.authorizationCode!, as: UTF8.self)
                }, callOptions: CallOptions(customMetadata: headers))
                
                print(response)
                
                // Store the credentials
                let appleCredentials = AppleCredentials(
                    user: appleCredentials.user,
                    email: appleCredentials.email,
                    identityToken: response.token.idToken,
                    refreshToken: response.token.refreshToken
                )
                
                _ = KeyChain.store(key: "apple", data: appleCredentials.data)
            }
        case .failure(let error):
            print("Authorization failed: \(error.localizedDescription)")
        }
    }
}
