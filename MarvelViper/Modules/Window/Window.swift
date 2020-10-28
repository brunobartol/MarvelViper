import UIKit

protocol WindowPresentation {
    
}

class Window: UIWindow {
    
    var presenter: WindowPresentation?
    
    override init(windowScene: UIWindowScene) {
        super.init(windowScene: windowScene)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

