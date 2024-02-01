
import Foundation
import AVFoundation
import AuthenticationServices
import Combine
import SwiftUI
import UIKit

@MainActor
class UserModel: NSObject, ObservableObject {
    static let shared = UserModel()
    
    enum Credential {
        case apple(Token)
        case device(String)
    }
    
    @Published
    var user: User?
    
    var credentials: [Credential] = []
    let provider = ASAuthorizationAppleIDProvider()
}
