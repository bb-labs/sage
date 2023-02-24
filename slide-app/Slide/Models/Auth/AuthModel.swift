
import Foundation
import AVFoundation
import AuthenticationServices

class AuthModel: NSObject, ObservableObject {
    @Published var credentials: ASAuthorizationAppleIDCredential?
    
    override init() {
        super.init()
        
        self.clearKeychain()
        
        guard let credentialsDataRestored = KeyChain.retrieve(key: "credentials") else { return }
        
        DispatchQueue.main.async {
            if let credentials = try? NSKeyedUnarchiver.unarchivedObject(ofClass: ASAuthorizationAppleIDCredential.self, from: credentialsDataRestored) {
                self.credentials = credentials
            }
        }
    }
    
    func getCredentialsDict() -> [String:String] {
        return [
            "user": self.credentials!.user,
            "token": String(decoding: self.credentials!.identityToken!, as: UTF8.self),
            "code": String(decoding: self.credentials!.authorizationCode!, as: UTF8.self),
        ]
    }
    
    func requestScopes(_ request: ASAuthorizationAppleIDRequest){
        request.requestedScopes = [.fullName, .email]
    }
    
    func clearKeychain() {
        let secItemClasses = [kSecClassGenericPassword, kSecClassInternetPassword, kSecClassCertificate, kSecClassKey, kSecClassIdentity]
        for itemClass in secItemClasses {
            let spec: NSDictionary = [kSecClass: itemClass]
            SecItemDelete(spec)
        }
    }
    
    
    func onSignUpComplete(_ authResult: Result<ASAuthorization, Error>) {
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
