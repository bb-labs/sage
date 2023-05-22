
import Foundation
import AVFoundation
import Combine
import SwiftUI

class UserModel: ObservableObject {
    @Published var auth = AuthModel()
    @Published var profile = ProfileModel()
    @Published var location = LocationModel()
    
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
    
    func addCredential(_ credential: Credentials) {
        self.auth.client.credentials.append(credential)
    }
}
