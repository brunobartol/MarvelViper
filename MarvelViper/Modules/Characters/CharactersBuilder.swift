import UIKit

class CharactersBuilder {
    static func build() -> UIViewController  {
        let storyboard = UIStoryboard.init(name: "Characters", bundle: nil)
        let view = CharactersViewController.instantiate(from: storyboard)
        
        let characterDetailModule = CharacterDetailBuilder.build
        
        let router = CharactersRouter(
            viewController: view,
            submodules: (
                characterDetailModule: characterDetailModule, ()
            )
        )
        
        let interactor = UseCasesFactory.charactersInteractor
        
        view.presenterBuilder = {
            CharactersPresenter(
                input: $0,
                dependencies: (
                    router: router,
                    useCases: (
                        input: (
                            fetchCharacters: interactor.characterList, ()
                        ),
                        output: (
                            characters: interactor.characters, ()
                        )
                    )
                )
            )
        }
        return view
    }
}
