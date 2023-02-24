
import Foundation
import AVFoundation
import AuthenticationServices

class AuthModel: NSObject, ObservableObject {
    let provider = ASAuthorizationAppleIDProvider()
    var credentials: ASAuthorizationAppleIDCredential?
    
    override init() {
        super.init()
        
        let credentialsDataRestored = KeyChain.retrieve(key: "credentials")
        
        if let credentials = try? NSKeyedUnarchiver.unarchivedObject(ofClass: ASAuthorizationAppleIDCredential.self, from: credentialsDataRestored!) {
            self.credentials = credentials
        }
    }
    
    func requestScopes(_ request: ASAuthorizationAppleIDRequest){
        request.requestedScopes = [.fullName, .email]
    }
    
    
    func onCompletion(_ authResult: Result<ASAuthorization, Error>) {
        switch authResult {
        case .success(let authResults):
            self.credentials = authResults.credential as? ASAuthorizationAppleIDCredential
            
            guard let credentialsData = try? NSKeyedArchiver.archivedData(withRootObject: self.credentials!, requiringSecureCoding: true) else { return }
            
            _ = KeyChain.store(key: "credentials", data: credentialsData)
            
        case .failure(let error):
            print("Authorisation failed: \(error.localizedDescription)")
        }
    }
}
