import UIKit

protocol LandingWireframe {
    func routeToWindow()
}

class LandingRouter {
    
    typealias Submodules = ()
    
    private weak var viewController: UIViewController?
    private let submodules: Submodules
    private let onTapCompletion: () -> Void
    
    init(viewController: UIViewController,
         onTapCompletion: @escaping () -> Void,
         submodules: Submodules
    ) {
        self.viewController = viewController
        self.submodules = submodules
        self.onTapCompletion = onTapCompletion
    }
}

extension LandingRouter: LandingWireframe {
    func routeToWindow() {
        onTapCompletion()
    }
}


