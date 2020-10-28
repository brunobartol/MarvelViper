import UIKit

protocol WindowWireframe {
    func routeToLanding()
}

class WindowRouter {
    
    private unowned let window: UIWindow
    private let submodules: Submodules
    
    typealias Submodules = (
        landingModule: (_ onTapCompletion: @escaping () -> Void) -> UIViewController,
        tabbarModule: () -> UITabBarController
    )
    
    init(
        window: UIWindow,
        submodules: Submodules
    ) {
        self.window = window
        self.submodules = submodules
    }
}

extension WindowRouter: WindowWireframe {
    
    func routeToLanding() {
        let landingView = self.submodules.landingModule { [weak self] in
            let tabbarView = self?.submodules.tabbarModule()
            self?.window.rootViewController = tabbarView
            self?.window.makeKeyAndVisible()
            UIView.transition(with: self!.window,
                              duration: 0.4,
                              options: .transitionCurlDown,
                              animations: nil,
                              completion: nil)
        }
        self.window.rootViewController = landingView
        self.window.makeKeyAndVisible()
    }
}

