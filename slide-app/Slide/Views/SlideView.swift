
import SwiftUI

struct SlideView: View {
    @EnvironmentObject var authModel: AuthModel
    
    var body: some View {
        if authModel.credentials != nil {
            CameraView()
        } else {
            AuthView()
        }
    }
}
