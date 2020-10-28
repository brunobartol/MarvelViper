import UIKit

protocol CharactersWireframe {
    func routeToWindow()
    func routeToCharacterDetail(for character: Character)
}

class CharactersRouter {
    
    private weak var viewController: UIViewController?
    private let submodules: Submodules
    
    typealias Submodules = (
        characterDetailModule: (_ character: Character) -> UIViewController, ()
    )
    
    init(
        viewController: UIViewController,
        submodules: Submodules
    ) {
        self.viewController = viewController
        self.submodules = submodules
    }
}

extension CharactersRouter: CharactersWireframe {
    func routeToWindow() {
    }
    
    func routeToCharacterDetail(for character: Character) {        
        let view = submodules.characterDetailModule(character)
        view.modalPresentationStyle = .formSheet
        view.modalTransitionStyle = .coverVertical
        self.viewController?.present(view, animated: true)
    }
}
