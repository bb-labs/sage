
import Foundation
import AuthenticationServices

protocol Credentials: Codable {}

extension Credentials {
    var data: Data {
        guard let data = try? JSONEncoder().encode(self) else { return Data() }
        
        return data
    }
    
    var dict: [String:String] {
        guard let dict = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else { return [:] }
        
        return dict as! [String:String]
    }
    
    var queryParams: [URLQueryItem] {
        self.dict.reduce(into: []) { params, param in
            params.append(URLQueryItem(name: param.key, value: param.value))
        }
    }
}

struct AppleCredentials: Credentials {
    let user: String
    var refreshToken: String
    var identityToken: String
}

struct GoogleCredentials: Credentials {
    var key = "AIzaSyAruGKwktB8dk7N5-MD4BVVeOqhuaSxcU8"
}

class AuthModel: ObservableObject {
    var client = HttpClient()
    
    @Published var apple: AppleCredentials?
    
    var loggedIn: Bool { self.apple != nil }
    
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
            
            Task {
                // Create user account
                let createUserRequest = SlideCreateUser(
                    id: appleCredentials.user,
                    email: appleCredentials.email,
                    authorizationCode: String(decoding: appleCredentials.authorizationCode!, as: UTF8.self)
                )
                
//                let createUserResponse: SlideCreateUser.Response = try await self.client.fetch(createUserRequest)
                
                // Store the credentials and associate with the client
                DispatchQueue.main.async {
//                    self.apple = AppleCredentials(
//                        user: appleCredentials.user,
//                        refreshToken: createUserResponse.refreshToken,
//                        identityToken: createUserResponse.identityToken
//                    )
                    self.apple = AppleCredentials(user: "", refreshToken: "", identityToken: "")
                    self.client.credentials = self.apple
                    
                    _ = KeyChain.store(key: "apple", data: self.apple!.data)
                }
            }
        case .failure(let error):
            print("Authorisation failed: \(error.localizedDescription)")
        }
    }
}


