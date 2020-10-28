import RxSwift
import RxRelay

final class ImageLoader {

    private let thumbnail: ApiImage?
    private let size: ImageSize
    private let imageRelay: PublishRelay<UIImage> = PublishRelay<UIImage>()
    lazy var image: Observable<UIImage> = self.imageRelay.asObservable()
    private(set) var bag = DisposeBag()
    
    init(thumbnail: ApiImage?, size: ImageSize) {
        self.thumbnail = thumbnail
        self.size = size
    }
    
    func fetchImage() -> Completable {
        imageDownloader
            .image(thumbnail: thumbnail, size: size)
            .map ({ [imageRelay] image in
                guard let image = image else { return }
                imageRelay.accept(image)
            })
            .asCompletable()
    }
}
