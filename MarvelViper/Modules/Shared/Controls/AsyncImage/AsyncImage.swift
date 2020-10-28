import UIKit
import RxSwift
import RxCocoa

struct AsyncImage {
    
    private let loader: ImageLoader
    private(set) var bag: DisposeBag = DisposeBag()
    
    var image: Observable<UIImage>
    
    init(imageLoader: ImageLoader,
         @AsyncImageBuilder builder: (ImageLoader) -> Observable<UIImage>
    ) {
        self.loader = imageLoader
        self.image = builder(self.loader)
    }
}

@_functionBuilder
struct AsyncImageBuilder {
    static func buildBlock(_ imageLoader: ImageLoader) -> Observable<UIImage> {
        imageLoader.image
    }
}
