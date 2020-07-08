import UIKit

class TabBarModuleBuilder {
    
    static func build(usingSubmodules submodules: TabBarRouter.Submodules) -> UIViewController {
        let tabs = TabBarRouter.tabs(usingSubmodules: submodules)
        let tabBarController = TabBarController(tabs: tabs)
        
        return tabBarController
    }
}
