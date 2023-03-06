
import Foundation
import AVFoundation


class UserModel: NSObject, ObservableObject {
    let auth = AuthModel()
    let location = LocationModel()
    
    func uploadProfileVideo(fileName: String, video: Data) async throws {
        let presignUrlRequest = SlidePresignUrl.Request(action: "PUT", fileName: fileName)
        let presignUrlResponse = try await self.auth.client.fetch(presignUrlRequest) as! SlidePresignUrl.Response
        
        let presignDataRequest = SlidePresignData.Request(
            body: video, url: presignUrlResponse.url, method: presignUrlResponse.method)
        
        let presignDataResponse = try await self.auth.client.fetch(presignDataRequest) as! SlidePresignData.Response
        
        print(presignDataResponse)
    }
    
    func publishLocation(_ coordinates: String) async throws {
        let location = SlideLocationPush.Location(coordinates: coordinates)
        let slideLocationPush = SlideLocationPush.Request(location: location)
        let slideLocationResponse = try await self.auth.client.fetch(slideLocationPush) as! SlideLocationPush.Response
        
        print(slideLocationResponse)
    }
}
