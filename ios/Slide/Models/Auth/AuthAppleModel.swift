
import Foundation
import AuthenticationServices

struct AppleCredentials: Credentials {
    let user: String
    let email: String?
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
                let createUserRequest = SlideCreateUser(user: User.with {
                    $0.token.userID = appleCredentials.user
                    $0.token.authCode = String(decoding: appleCredentials.authorizationCode!, as: UTF8.self)
                    $0.email = appleCredentials.email!
                })
                
                let createUserResponse: User.Token = try await self.httpClient.fetch(createUserRequest)
                
                // Store the credentials
                DispatchQueue.main.async {
                    let appleCredentials = AppleCredentials(
                        user: appleCredentials.user,
                        email: appleCredentials.email,
                        identityToken: createUserResponse.identityToken
                    )
                    
                    self.credentials.append(appleCredentials)
                    
                    _ = KeyChain.store(key: "apple", data: appleCredentials.data)
                }
            }
        case .failure(let error):
            print("Authorization failed: \(error.localizedDescription)")
        }
    }
}
