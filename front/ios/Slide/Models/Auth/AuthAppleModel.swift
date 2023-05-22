
import Foundation
import AuthenticationServices

struct AppleCredentials: Credentials {
    let user: String
    let email: String?
    var refreshToken: String
    var identityToken: String
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
                // Create user account
                let createUserRequest = SlideCreateUser(
                    id: appleCredentials.user,
                    email: appleCredentials.email,
                    authorizationCode: String(decoding: appleCredentials.authorizationCode!, as: UTF8.self)
                )
                
                let createUserResponse: SlideCreateUser.Response = try await self.client.fetch(createUserRequest)
                
                // Store the credentials and associate with the client
                DispatchQueue.main.async {
                    let appleCredentials = AppleCredentials(
                        user: appleCredentials.user,
                        email: appleCredentials.email,
                        refreshToken: createUserResponse.refreshToken,
                        identityToken: createUserResponse.identityToken
                    )
                    
                    self.client.credentials.append(appleCredentials)
                    
                    _ = KeyChain.store(key: "apple", data: appleCredentials.data)
                }
            }
        case .failure(let error):
            print("Authorisation failed: \(error.localizedDescription)")
        }
    }
}
