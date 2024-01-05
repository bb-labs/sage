
import Foundation
import AVFoundation
import Combine
import SwiftUI
import UIKit

class UserModel: NSObject, ObservableObject {
    var user = User()
    
    override init() {
        super.init()
    }
}
