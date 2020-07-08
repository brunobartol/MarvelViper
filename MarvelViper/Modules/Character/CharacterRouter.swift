import UIKit

protocol CharacterWireframe {
    func toCharacter(character: Character) -> Void
}

class CharacterRouter {
    
    var viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension CharacterRouter: CharacterWireframe {
    
    func toCharacter(character: Character) {
//        let view = CharacterDetailBuilder.build(usingNavigationFactory: NavigationBuilder.build, character: character)
//        view.pushViewController(view, animated: true)
    }
}
