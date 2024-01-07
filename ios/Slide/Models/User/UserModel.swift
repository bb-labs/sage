
import Foundation
import AVFoundation
import Combine
import SwiftUI
import UIKit

class UserModel: NSObject, ObservableObject {
    static let shared = UserModel()
    var user = User()
}
