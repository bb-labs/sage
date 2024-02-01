
import SwiftUI

struct SlideView: View {
    @StateObject var userModel = UserModel.shared

    var body: some View {
        if userModel.user != nil {
            VideoChatView(webRTCModel: WebRTCModel(UserModel.shared.user?.id == ""
                                                   ? User.with {$0.id = ""}
                                                   : User.with {$0.id = ""}))
        } else {
            AuthView()
        }
    }
}

