
import Foundation
import AVFoundation
import Combine
import SwiftUI

class UserModel: ObservableObject {
    @Published var auth = AuthModel()
    @Published var profile: ProfileModel?
    @Published var location = LocationModel()
    
    var anyCancellable: AnyCancellable? = nil
    
    init() {
        anyCancellable = auth.objectWillChange.sink { [weak self] (_) in
            withAnimation(.easeIn(duration: 1)) {
                self?.objectWillChange.send()
            }
        }
    }
    
    func createProfile() {
        DispatchQueue.main.async {
            withAnimation(.linear(duration: 1)) {
                self.profile = ProfileModel()
            }
        }
    }
    
    func uploadProfileVideo(fileName: String, video: Data) async throws {
        let presignUrlRequest = SlidePresignUrl(action: APIMethod.PUT, fileName: fileName)
        let presignUrlResponse: SlidePresignUrl.Response = try await self.auth.client.fetch(presignUrlRequest)
        
        let presignDataRequest = SlidePresignData(body: video, meta: presignUrlResponse)
        let presignDataResponse: SlidePresignData.Response = try await self.auth.client.fetch(presignDataRequest)
        
        print(presignDataResponse)
    }
    
    func publishLocation(_ coordinates: String) async throws {
        let slideUpdateLocationRequest = SlideUpdateLocation(coordinates)
        let slideUpdateLocationResponse: SlideUpdateLocation.Response = try await self.auth.client.fetch(slideUpdateLocationRequest)
        
        print(slideUpdateLocationResponse)
    }
}
