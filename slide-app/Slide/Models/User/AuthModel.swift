
import Foundation
import AuthenticationServices

protocol Credentials: Codable {}

struct AppleCredentials: Credentials {
    let user: String
    
    var identityToken: String
    var refreshToken: String?
    var authorizationCode: String?
}

struct GoogleCredentials: Credentials {
    var key = "AIzaSyAruGKwktB8dk7N5-MD4BVVeOqhuaSxcU8"
}

class AuthModel {
    var client = HttpClient()
    
    var apple: AppleCredentials?
    
    init() {
        KeyChain.clearKeychain()
        
        guard KeyChain.retrieve(key: "apple") != nil else { return }
    }
    
    func requestAppleScopes(_ request: ASAuthorizationAppleIDRequest){
        request.requestedScopes = [.fullName, .email]
    }
    
    
    func onAppleSignUpComplete(_ authResult: Result<ASAuthorization, Error>) {
        switch authResult {
        case .success(let authResults):
            let appleCredentials = authResults.credential as! ASAuthorizationAppleIDCredential
           
            self.apple = AppleCredentials(
                user: appleCredentials.user,
                identityToken: String(decoding: appleCredentials.identityToken!, as: UTF8.self),
                authorizationCode: String(decoding: appleCredentials.authorizationCode!, as: UTF8.self)
            )
            
            self.client.credentials = self.apple
            
            let user = SlideCreateUser.User(
                id: appleCredentials.user,
                email: appleCredentials.email
            )
            
            let createUserRequest = SlideCreateUser.Request(user: user)
            
            Task {
                let createUserResponse = try await self.client.fetch(createUserRequest) as! SlideCreateUser.Response
                
                // Only use auth code on first request to get refresh_token
                self.apple!.identityToken = createUserResponse.identityToken
                self.apple!.refreshToken = createUserResponse.refreshToken
                self.apple!.authorizationCode = nil
                self.client.credentials = self.apple
            }
            
            
            KeyChain.store(key: "apple", data: self.app)
            
        case .failure(let error):
            print("Authorisation failed: \(error.localizedDescription)")
        }
    }
}


