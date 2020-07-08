import UIKit

class CharacterBuilder {
    static func build(usingNavigationFactory factory: NavigationFactory) -> UINavigationController  {
        let storyboard = UIStoryboard.init(name: "Character", bundle: nil)
        let view = storyboard.instantiateViewController(identifier: "CharacterViewController") as! CharacterViewController
        let router = CharacterRouter(viewController: view)
        let interactor = CharacterInteractor(service: CharacterService.shared)
        
        view.presenterBuilder = {
            CharacterPresenter(
                input: $0,
                router: router,
                useCases: (
                    characterList: interactor.characterList, ()
                )
            )
        }
        
        return factory(view)
    }
}
