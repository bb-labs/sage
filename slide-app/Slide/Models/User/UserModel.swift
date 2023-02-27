
import Foundation
import AVFoundation
import AuthenticationServices

// Key ID
// K4UJQY4V8H

extension ASAuthorizationAppleIDCredential {
    func getCredentials() -> Credentials {
        return [
            "user": self.user,
            "token": String(decoding: self.identityToken!, as: UTF8.self),
            "code": String(decoding: self.authorizationCode!, as: UTF8.self),
        ]
    }
}

class UserModel: NSObject, ObservableObject {
    var client: HttpClient?
    @Published var credentials: ASAuthorizationAppleIDCredential?
    
    override init() {
        super.init()
        
        KeyChain.clearKeychain()
        
        guard let credentialsData = KeyChain.retrieve(key: "credentials") else { return }
        
        DispatchQueue.main.async {
            if let credentials = try? NSKeyedUnarchiver.unarchivedObject(ofClass: ASAuthorizationAppleIDCredential.self, from: credentialsData) {
                self.credentials = credentials
                self.client = HttpClient(credentials: self.credentials!.getCredentials())
            }
        }
    }
    
    func requestScopes(_ request: ASAuthorizationAppleIDRequest){
        request.requestedScopes = [.fullName, .email]
    }
    
    
    func onSignUpComplete(_ authResult: Result<ASAuthorization, Error>) {
        switch authResult {
        case .success(let authResults):
            self.credentials = authResults.credential as? ASAuthorizationAppleIDCredential
            self.client = HttpClient(credentials: self.credentials!.getCredentials())
            
            let user = SlideCreateUser.User(
                id: self.credentials!.user,
                email: self.credentials!.email
            )
            
            let createUserRequest = SlideCreateUser.Request(user: user)
            
            Task {
                let createUserResponse = try await self.client!.fetch(createUserRequest) as! SlideCreateUser.Response
                print(createUserResponse)
            }
            
            
            guard let credentialsData = try? NSKeyedArchiver.archivedData(withRootObject: self.credentials!, requiringSecureCoding: true) else { return }
            
            _ = KeyChain.store(key: "credentials", data: credentialsData)
            
        case .failure(let error):
            print("Authorisation failed: \(error.localizedDescription)")
        }
    }
    
    func uploadProfileVideo(fileName: String, video: Data) async throws {
        if let client = self.client {
            let presignUrlRequest = SlidePresignUrl.Request(action: "PUT", fileName: fileName)
            let presignUrlResponse = try await client.fetch(presignUrlRequest) as! SlidePresignUrl.Response
            
            let presignDataRequest = SlidePresignData.Request(
                body: video, url: presignUrlResponse.url, method: presignUrlResponse.method)
            
            let presignDataResponse = try await client.fetch(presignDataRequest) as! SlidePresignData.Response
            
            print(presignDataResponse)
        }
    }
    
    func publishLocation(_ coordinates: String) async throws {
        let slideLocationPush = SlideLocationPush.Request(location: SlideLocationPush.Location(coordinates: coordinates))
        
        if let client = self.client {
            let slideLocationResponse = try await client.fetch(slideLocationPush) as! SlideLocationPush.Response
            
            print(slideLocationResponse)
        }
    }
}
