
import SwiftUI

struct SlideView: View {
    @EnvironmentObject var userModel: UserModel
    
    var body: some View {
        if userModel.credentials != nil {
            CameraView()
        } else {
            AuthView()
        }
    }
}
