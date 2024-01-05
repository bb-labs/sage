
import Foundation
import AuthenticationServices

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
                let createUserRequest = SlideCreateUser(user: User.with {
                    $0.token.id = appleCredentials.user
                    $0.token.authCode = String(decoding: appleCredentials.authorizationCode!, as: UTF8.self)
                    $0.email = appleCredentials.email ?? ""
                }, credentials: AppleCredentials(identityToken: String(decoding: appleCredentials.identityToken!, as: UTF8.self)))
                
                
                let response = try await self.sageService.client.makeCreateUserCall(CreateUserRequest.with {
                    $0.user.id = appleCredentials.user
                    $0.user.email = appleCredentials.email ?? ""
                    $0.token.authCode = String(decoding: appleCredentials.authorizationCode!, as: UTF8.self)
                })
                
                // Store the credentials
                let appleCredentials = AppleCredentials(
                    user: appleCredentials.user,
                    email: appleCredentials.email,
                    identityToken: createUserResponse.idToken,
                    refreshToken: createUserResponse.refreshToken
                )
                
                _ = KeyChain.store(key: "apple", data: appleCredentials.data)
            }
        case .failure(let error):
            print("Authorization failed: \(error.localizedDescription)")
        }
    }
}
