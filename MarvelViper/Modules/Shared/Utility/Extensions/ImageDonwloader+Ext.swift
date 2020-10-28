import AlamofireImage
import RxSwift

enum ImageSize: String {
    case small = "/portrait_small."
    case large = "/portrait_uncanny."
}

let imageDownloader = ImageDownloader(
    configuration: .default,
    downloadPrioritization: .fifo,
    maximumActiveDownloads: 4,
    imageCache: AutoPurgingImageCache()
)

extension ImageDownloader {
    func image(thumbnail: ApiImage?, size: ImageSize) -> Single<UIImage?> {
        
        return Single<UIImage?>.create { (single) -> Disposable in
            
            guard let thumbnail = thumbnail else { return Disposables.create {} }
            
            let urlString = thumbnail.path! + size.rawValue + thumbnail.ext!
            
            do {
                let urlRequest = try MarvelAPI.image(destination: urlString).asURLRequest()
                
                imageDownloader.download(urlRequest) { response in
                    if case .success(let image) = response.result {
                        single(.success(image))
                    }
                }
            } catch {
                single(.error(ApiError.genericError))
            }
            
            return Disposables.create {}
        }
    }
}
