

import Foundation

extension UserModel {
    func uploadProfileVideo(fileName: String, video: Data) async throws {
        let presignUrlRequest = SlidePresignUrl( presignInfo: PresignedUrlRequest.with {
            $0.action = APIMethod.PUT.rawValue
            $0.fileName = fileName
        })
        
        let presignUrlResponse: PresignedUrlResponse = try await self.httpClient.fetch(presignUrlRequest)
        
        let presignDataRequest = SlidePresignData(data: video, meta: presignUrlResponse)
        let presignDataResponse: SlidePresignData.Response = try await self.httpClient.fetch(presignDataRequest)
        
        print(presignDataResponse)
    }
}
