
import Foundation
import AVFoundation
import Combine

class UserModel: ObservableObject {
    @Published var auth = AuthModel()
    let location = LocationModel()
    
    var anyCancellable: AnyCancellable? = nil
    
    init() {
        anyCancellable = auth.objectWillChange.sink { [weak self] (_) in
            self?.objectWillChange.send()
        }
    }
    
    func uploadProfileVideo(fileName: String, video: Data) async throws {
        let presignUrlRequest = SlidePresignUrl(action: APIMethod.PUT, fileName: fileName)
        let presignUrlResponse: SlidePresignUrl.Response = try await self.auth.client.fetch(presignUrlRequest)
        
        let presignDataRequest = SlidePresignData(body: video, url: presignUrlResponse.url, method: presignUrlResponse.method)
        let presignDataResponse: SlidePresignData.Response = try await self.auth.client.fetch(presignDataRequest)
        
        print(presignDataResponse)
    }
    
    func publishLocation(_ coordinates: String) async throws {
        let slideUpdateLocationRequest = SlideUpdateLocation(coordinates)
        let slideUpdateLocationResponse: SlideUpdateLocation.Response = try await self.auth.client.fetch(slideUpdateLocationRequest)
        
        print(slideUpdateLocationResponse)
    }
}
