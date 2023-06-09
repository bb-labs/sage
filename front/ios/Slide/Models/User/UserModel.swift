
import Foundation
import AVFoundation
import Combine
import SwiftUI

class UserModel: ObservableObject {
    @Published var user = User()
    @Published var auth = AuthModel()
    @Published var profile = ProfileModel()
    @Published var location = LocationModel()
    
    
    func uploadProfileVideo(fileName: String, video: Data) async throws {
        let presignUrlRequest = SlidePresignUrl( presignInfo: PresignedUrlRequest.with {
            $0.action = APIMethod.PUT.rawValue
            $0.fileName = fileName
        })
        
        let presignUrlResponse: PresignedUrlResponse = try await self.auth.client.fetch(presignUrlRequest)
        
        let presignDataRequest = SlidePresignData(data: video, meta: presignUrlResponse)
        let presignDataResponse: SlidePresignData.Response = try await self.auth.client.fetch(presignDataRequest)
        
        print(presignDataResponse)
    }
    
    func publishLocation(_ latitude: Int32, _ longitude: Int32) async throws {
        let slideUpdateLocationRequest = SlideUpdateLocation( location: Location.with {
            $0.type = "Point"
            $0.latitude = latitude
            $0.longitude = longitude
        })
        
        let slideUpdateLocationResponse: SlideUpdateLocation.Response = try await self.auth.client.fetch(slideUpdateLocationRequest)
        
        print(slideUpdateLocationResponse)
    }
    
    func addCredential(_ credential: Credentials) {
        self.auth.client.credentials.append(credential)
    }
}
