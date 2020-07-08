import UIKit

class TabBarRouter {
    
    var viewController: UIViewController
    
    typealias Submodules = (
        character: UIViewController,
        comic: UIViewController,
        settings: UIViewController
    )
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension TabBarRouter {
    static func tabs(usingSubmodules submodules: Submodules) -> MarvelTabs {
        let characterTabItem = UITabBarItem(title: "Heroes", image: UIImage(systemName: "person.fill"), tag: 11)
        let comicTabItem = UITabBarItem(title: "Comics", image: UIImage(systemName: "person.fill"), tag: 12)
        let settingsTabItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "person.fill"), tag: 13)
        
        submodules.character.tabBarItem = characterTabItem
        submodules.comic.tabBarItem = comicTabItem
        submodules.settings.tabBarItem = settingsTabItem
        
        return (
            character: submodules.character,
            comic: submodules.comic,
            settings: submodules.settings
        )
    }
}
