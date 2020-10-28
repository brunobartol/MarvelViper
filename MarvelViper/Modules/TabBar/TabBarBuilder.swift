import UIKit

public final class TabBarBuilder {
    
    public static func build() -> UITabBarController {
        
        let submodules: TabBarRouter.Submodules = (
            characters: CharactersBuilder.build(),
            comics: CharactersBuilder.build(),
            settings: CharactersBuilder.build()
        )
        
        let tabs: MarvelTabs = TabBarRouter.tabs(usingSubmodules: submodules)
        
        let presenter = TabBarPresenter(useCases: ())
        let view = TabBarController(tabs: tabs)
        
        presenter.view = view
        view.presenter = presenter
        
        return view
    }
}
