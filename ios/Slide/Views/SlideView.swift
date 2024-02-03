
import SwiftUI

struct SlideView: View {
    @StateObject var userModel = UserModel.shared

    var body: some View {
        if userModel.user != nil {
            VideoChatView(webRTCModel: WebRTCModel(UserModel.shared.user?.id == "000991.ac516b9246e945339ef7ee81f5250f30.0219"
                                                   ? User.with {$0.id = "000913.0765e5623e824bfdb5cf145f1510b55e.0739"}
                                                   : User.with {$0.id = "000991.ac516b9246e945339ef7ee81f5250f30.0219"}))
        } else {
            AuthView()
        }
    }
}

