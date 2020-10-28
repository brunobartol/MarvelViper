import UIKit

public final class CharacterDetailBuilder {
    static func build(using character: Character) -> UIViewController {
        let storyboard = UIStoryboard.init(name: "CharacterDetail", bundle: nil)
        let view = CharacterDetailViewController.instantiate(from: storyboard)
        
        let router = CharacterDetailRouter(viewController: view,
                                           submodules: ())
                
        view.presenterBuilder = {
            CharacterDetailPresenter(
                input: $0,
                dependencies: (
                    character: character,
                    router: router,
                    useCases: (
                        input: (),
                        output: (
                            
                        )
                    )
                )
            )
        }
        
        return view
    }
}
