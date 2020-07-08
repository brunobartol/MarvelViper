import UIKit

typealias MarvelTabs = (
    character: UIViewController,
    comic: UIViewController,
    settings: UIViewController
)

class TabBarController: UITabBarController {
    
    init(tabs: MarvelTabs) {
        super.init(nibName: nil, bundle: nil)
        viewControllers = [tabs.character, tabs.comic, tabs.settings]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
