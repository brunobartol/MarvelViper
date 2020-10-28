import UIKit

typealias MarvelTabs = (
    characters: UIViewController,
    comics: UIViewController,
    settings: UIViewController
)

protocol TabBarPresentation {
    
}

protocol TabBarView: class {
    
}

class TabBarController: UITabBarController {
    
    var presenter: TabBarPresentation?
    
    init(tabs: MarvelTabs) {
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = [tabs.characters, tabs.comics, tabs.settings]
     }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension TabBarController: TabBarView {
    
}
