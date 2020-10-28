import UIKit

protocol CharacterDetailWireframe {
    func routeToWindow()
}

class CharacterDetailRouter {
    
    typealias Submodules = ()
    
    private weak var viewController: UIViewController?
    private let submodules: Submodules
    
    init(viewController: UIViewController,
         submodules: Submodules
    ) {
        self.viewController = viewController
        self.submodules = submodules
    }
}

extension CharacterDetailRouter: CharacterDetailWireframe {
    func routeToWindow() {
    }
}

