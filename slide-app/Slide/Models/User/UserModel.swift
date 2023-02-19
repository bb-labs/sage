
import Foundation


class UserModel: ObservableObject {
    let httpClient = HttpClient()
    
    func uploadProfileVideo(fileName: String, video: Data) {
        Task {
            let presignUrlRequest = SlidePresignUrl.Request(action: "PUT", fileName: fileName)
            let presignUrlResponse = try await self.httpClient.fetch(presignUrlRequest) as! SlidePresignUrl.Response
            
            let presignDataRequest = SlidePresignData.Request(body: video, url: presignUrlResponse.url, method: presignUrlResponse.method)
            let presignDataResponse = try await self.httpClient.fetch(presignDataRequest) as! SlidePresignData.Response
            
            print(presignDataResponse)
        }
        
    }
}
