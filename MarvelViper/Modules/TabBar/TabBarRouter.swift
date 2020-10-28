import UIKit

class TabBarRouter {
    
    typealias Submodules = (
        characters: UIViewController,
        comics: UIViewController,
        settings: UIViewController
    )
    
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension TabBarRouter {
    static func tabs(usingSubmodules submodules: Submodules) -> MarvelTabs {
        
        let charactersTabBarItem = UITabBarItem(title: "Heroes", image: UIImage(systemName: "person.fill"), tag: 100)
        let comicsTabBarItem = UITabBarItem(title: "Comics", image: UIImage(systemName: "book.fill"), tag: 101)
        let settingsTabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 102)
        
        submodules.characters.tabBarItem = charactersTabBarItem
        submodules.comics.tabBarItem = comicsTabBarItem
        submodules.settings.tabBarItem = settingsTabBarItem
        
        return (
            characters: submodules.characters,
            comics: submodules.comics,
            settings: submodules.settings
        )
    }
}

extension TabBarRouter: TabBarWireframe {
    
}
